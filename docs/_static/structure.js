const DEEPSLATE = 'https://cdn.jsdelivr.net/npm/deepslate@0.27.2/+esm';
const MCMETA = 'https://raw.githubusercontent.com/misode/mcmeta/refs/tags';

let library = null;
const resources = new Map();
const structures = new Map();
const providers = new Map();

function loadLibrary() {
  library ??= import(DEEPSLATE);
  return library;
}

const fetchJson = (url) => fetch(url).then((r) => r.ok ? r.json() : Promise.reject(new Error(url)));
const fetchImage = (url) => fetch(url).then((r) => r.ok ? r.blob() : Promise.reject(new Error(url))).then(createImageBitmap);

function loadResources(version) {
  if (!resources.has(version)) {
    resources.set(version, (async () => {
      const ds = await loadLibrary();
      const [blocks, definitions, models, uvs, atlas] = await Promise.all([
        fetchJson(`${MCMETA}/${version}-summary/blocks/data.min.json`),
        fetchJson(`${MCMETA}/${version}-summary/assets/block_definition/data.min.json`),
        fetchJson(`${MCMETA}/${version}-summary/assets/model/data.min.json`),
        fetchJson(`${MCMETA}/${version}-atlas/all/data.min.json`),
        fetchImage(`${MCMETA}/${version}-atlas/all/atlas.png`),
      ]);
      const blockDefinitions = {};
      for (const [id, data] of Object.entries(definitions)) {
        blockDefinitions[`minecraft:${id}`] = ds.BlockDefinition.fromJson(data);
      }
      const blockModels = {};
      for (const [id, data] of Object.entries(models)) {
        blockModels[`minecraft:${id}`] = ds.BlockModel.fromJson(data);
      }
      const base = {
        getBlockDefinition: (id) => blockDefinitions[id.toString()] ?? null,
        getBlockModel: (id) => blockModels[id.toString()] ?? null,
        getBlockFlags: () => ({ opaque: false }),
        getBlockProperties: (id) => blocks[id.path]?.[0] ?? null,
        getDefaultBlockProperties: (id) => blocks[id.path]?.[1] ?? null,
      };
      Object.values(blockModels).forEach((model) => model.flatten(base));
      return { base, uvs, atlas };
    })());
  }
  return resources.get(version);
}

function loadStructure(path) {
  if (!structures.has(path)) {
    const root = document.documentElement.dataset.content_root ?? '';
    structures.set(path, (async () => {
      const ds = await loadLibrary();
      const response = await fetch(`${root}_static/structures/${path}.nbt`);
      if (!response.ok) throw new Error(`cannot load the structure ${path}`);
      const file = ds.NbtFile.read(new Uint8Array(await response.arrayBuffer()));
      return ds.Structure.fromNbt(file.root);
    })());
  }
  return structures.get(path);
}

function texturesOf(ds, base, structure) {
  const textures = new Set();
  const seen = new Set();
  for (const { state } of structure.getBlocks()) {
    const key = state.toString();
    if (seen.has(key)) continue;
    seen.add(key);
    const definition = base.getBlockDefinition(state.getName());
    for (const variant of definition?.getModelVariants(state.getProperties()) ?? []) {
      const model = base.getBlockModel(ds.Identifier.parse(variant.model));
      for (const value of Object.values(model?.textures ?? {})) {
        const texture = typeof value === 'string' ? value : value?.sprite;
        if (texture && !texture.startsWith('#')) textures.add(ds.Identifier.parse(texture).toString());
      }
    }
  }
  return textures;
}

async function loadProvider(version, path) {
  const key = `${version}/${path}`;
  if (!providers.has(key)) {
    providers.set(key, (async () => {
      const ds = await loadLibrary();
      const [{ base, uvs, atlas }, structure] = await Promise.all([loadResources(version), loadStructure(path)]);
      const textures = [...texturesOf(ds, base, structure)].filter((id) => uvs[id.slice('minecraft:'.length)]);
      const columns = 2 ** Math.ceil(Math.log2(Math.sqrt(textures.length + 1)));
      const canvas = document.createElement('canvas');
      canvas.width = canvas.height = columns * 16;
      const context = canvas.getContext('2d');
      context.imageSmoothingEnabled = false;
      const idMap = {};
      textures.forEach((id, i) => {
        const [u, v, du] = uvs[id.slice('minecraft:'.length)];
        const [x, y] = [(i + 1) % columns, Math.floor((i + 1) / columns)];
        context.drawImage(atlas, u, v, du, du, x * 16, y * 16, 16, 16);
        idMap[id] = [x / columns, y / columns, (x + 1) / columns, (y + 1) / columns];
      });
      const size = columns * 16;
      const textureAtlas = new ds.TextureAtlas(context.getImageData(0, 0, size, size), idMap);
      const provider = {
        ...base,
        getTextureAtlas: () => textureAtlas.getTextureAtlas(),
        getTextureUV: (id) => textureAtlas.getTextureUV(id),
        getPixelSize: () => textureAtlas.getPixelSize(),
      };
      return { provider, structure };
    })());
  }
  return providers.get(key);
}

function viewMatrix(pitch, yaw, distance, center, pan) {
  const [cp, sp, cy, sy] = [Math.cos(pitch), Math.sin(pitch), Math.cos(yaw), Math.sin(yaw)];
  const [x, y, z] = center.map((c) => -c);
  const m = [
    cy, sp * sy, -cp * sy, 0,
    0, cp, sp, 0,
    sy, -sp * cy, cp * cy, 0,
    0, 0, 0, 1,
  ];
  m[12] = m[0] * x + m[4] * y + m[8] * z + pan[0];
  m[13] = m[1] * x + m[5] * y + m[9] * z + pan[1];
  m[14] = m[2] * x + m[6] * y + m[10] * z - distance;
  return new Float32Array(m);
}

const TAN = Math.tan(35 * Math.PI / 180);
const FIT = 0.8 / Math.sin(35 * Math.PI / 180);
const MARGIN = 0.92;
const PITCH = 0.3;
const YAW = -Math.PI / 4;
const RESUME = 4000;
const MOTION = !window.matchMedia('(prefers-reduced-motion: reduce)').matches;

function frameOf(structure) {
  const min = [Infinity, Infinity, Infinity];
  const max = [-Infinity, -Infinity, -Infinity];
  for (const { pos, state } of structure.getBlocks()) {
    if (state.getName().path.endsWith('air')) continue;
    for (let i = 0; i < 3; i++) {
      min[i] = Math.min(min[i], pos[i]);
      max[i] = Math.max(max[i], pos[i] + 1);
    }
  }
  if (min[0] === Infinity) return { center: structure.getSize().map((s) => s / 2), radius: 1 };
  const center = min.map((m, i) => (m + max[i]) / 2);
  const radius = Math.hypot(...max.map((m, i) => m - min[i])) / 2;
  return { center, radius };
}

function homeOf(structure, bounds, aspect) {
  const corners = [];
  for (const { pos, state } of structure.getBlocks()) {
    if (state.getName().path.endsWith('air')) continue;
    for (let i = 0; i < 8; i++) corners.push([pos[0] + (i & 1), pos[1] + ((i >> 1) & 1), pos[2] + ((i >> 2) & 1)]);
  }
  let [pan, zoom] = [0, 1];
  for (let round = 0; round < 3 && corners.length; round++) {
    const distance = bounds.radius * FIT / zoom;
    const m = viewMatrix(PITCH, YAW, distance, bounds.center, [0, pan]);
    let [low, high, side] = [Infinity, -Infinity, 0];
    for (const [x, y, z] of corners) {
      const depth = -(m[2] * x + m[6] * y + m[10] * z + m[14]) * TAN;
      const top = (m[1] * x + m[5] * y + m[9] * z + m[13]) / depth;
      low = Math.min(low, top);
      high = Math.max(high, top);
      side = Math.max(side, Math.abs((m[0] * x + m[4] * y + m[8] * z + m[12]) / (depth * aspect)));
    }
    pan -= (low + high) / 2 * distance * TAN;
    const extent = Math.max((high - low) / 2, side);
    if (extent > MARGIN) zoom *= MARGIN / extent;
  }
  return { pan: [0, pan], zoom };
}

class StructureView {
  constructor(element) {
    this.element = element;
    this.canvas = element.querySelector('canvas');
    this.pitch = PITCH;
    this.yaw = YAW;
    this.zoom = 1;
    this.pan = [0, 0];
    this.speed = MOTION ? 1 : 0;
    this.touched = -Infinity;
    this.renderer = null;
    this.request = 0;
    this.listen();
  }

  touch() {
    this.speed = 0;
    this.touched = performance.now();
  }

  async start() {
    if (this.renderer || this.starting) return;
    this.starting = true;
    try {
      const ds = await loadLibrary();
      const { provider, structure } = await loadProvider(this.element.dataset.version, this.element.dataset.structure);
      if (!this.visible) return;
      const gl = this.canvas.getContext('webgl');
      this.renderer = new ds.StructureRenderer(gl, structure, provider, { useInvisibleBlockBuffer: false });
      this.gl = gl;
      this.bounds = frameOf(structure);
      if (!this.home) {
        this.home = homeOf(structure, this.bounds, (this.canvas.clientWidth / this.canvas.clientHeight) || 4 / 3);
        this.pan = [...this.home.pan];
        this.zoom = this.home.zoom;
      }
      this.element.classList.add('bs-ready');
      this.loop();
    } catch (error) {
      this.element.classList.add('bs-failed');
      console.error(error);
    } finally {
      this.starting = false;
    }
  }

  stop() {
    cancelAnimationFrame(this.request);
    if (!this.renderer) return;
    this.gl.getExtension('WEBGL_lose_context')?.loseContext();
    this.renderer = null;
    const canvas = this.canvas.cloneNode();
    this.canvas.replaceWith(canvas);
    this.canvas = canvas;
    this.listen();
  }

  loop() {
    this.request = requestAnimationFrame((time) => {
      const step = this.last === undefined ? 0 : time - this.last;
      this.last = time;
      if (MOTION && !this.drag && time - this.touched > RESUME) this.speed = Math.min(1, this.speed + step / 1000);
      this.yaw += this.speed * step / 4000;
      this.draw();
      this.loop();
    });
  }

  distance() {
    return this.bounds.radius * FIT / this.zoom;
  }

  draw() {
    const { canvas, gl, renderer } = this;
    const ratio = window.devicePixelRatio || 1;
    const [width, height] = [canvas.clientWidth * ratio, canvas.clientHeight * ratio].map(Math.round);
    if (canvas.width !== width || canvas.height !== height) {
      canvas.width = width;
      canvas.height = height;
    }
    renderer.setViewport(0, 0, width, height);
    gl.clearColor(0, 0, 0, 0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    renderer.drawStructure(viewMatrix(this.pitch, this.yaw, this.distance(), this.bounds.center, this.pan));
  }

  listen() {
    const canvas = this.canvas;
    canvas.addEventListener('contextmenu', (event) => event.preventDefault());
    canvas.addEventListener('pointerdown', (event) => {
      this.touch();
      canvas.setPointerCapture(event.pointerId);
      this.drag = { x: event.clientX, y: event.clientY, move: event.button !== 0 || event.shiftKey };
    });
    canvas.addEventListener('pointermove', (event) => {
      if (!this.drag) return;
      const [dx, dy] = [event.clientX - this.drag.x, event.clientY - this.drag.y];
      if (this.drag.move && this.bounds) {
        const scale = 2 * TAN * this.distance() / canvas.clientHeight;
        this.pan = [this.pan[0] + dx * scale, this.pan[1] - dy * scale];
      } else {
        this.yaw += dx / 100;
        this.pitch = Math.max(-1.5, Math.min(1.5, this.pitch + dy / 100));
      }
      this.drag.x = event.clientX;
      this.drag.y = event.clientY;
    });
    canvas.addEventListener('pointerup', () => { this.drag = null; });
    canvas.addEventListener('pointercancel', () => { this.drag = null; });
    canvas.addEventListener('dblclick', () => {
      this.pitch = PITCH;
      this.yaw = YAW;
      this.zoom = this.home?.zoom ?? 1;
      this.pan = [...(this.home?.pan ?? [0, 0])];
    });
    canvas.addEventListener('wheel', (event) => {
      if (document.activeElement !== canvas) return;
      event.preventDefault();
      this.touch();
      this.zoom = Math.max(0.5, Math.min(4, this.zoom * Math.exp(-event.deltaY / 500)));
    }, { passive: false });
  }
}

function initStructureViews() {
  const elements = document.querySelectorAll('.bs-structure');
  if (!elements.length) return;
  const idle = window.requestIdleCallback ?? ((callback) => setTimeout(callback, 1));
  idle(() => new Set([...elements].map((e) => e.dataset.version)).forEach((v) => loadResources(v).catch(() => {})));
  const views = new Map();
  const observer = new IntersectionObserver((entries) => {
    for (const entry of entries) {
      const view = views.get(entry.target);
      view.visible = entry.isIntersecting;
      if (entry.isIntersecting) view.start();
      else view.stop();
    }
  }, { rootMargin: '200px' });
  elements.forEach((element) => {
    views.set(element, new StructureView(element));
    observer.observe(element);
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initStructureViews);
} else {
  initStructureViews();
}
