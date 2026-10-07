// Served only by `docs watch`: show a rebuilt page by replacing the blocks of the article that
// changed, and reload when more than the article did. Stylesheets are swapped in place.
const page = (location.pathname.replace(/^\//, '').replace(/\/$/, '/index') || 'index').replace(/\.html$/, '');
const ARTICLE = 'article.bz-article-main';
const AROUND = ['title', '.bz-sidebar-nav', '.bz-sidebar-toc'];

const read = async () => {
  const response = await fetch(location.pathname, { cache: 'no-store' });
  return new DOMParser().parseFromString(await response.text(), 'text/html');
};

// The page as it was built, to compare with: scripts have changed the one on screen since
let built = read();

async function refresh() {
  const [before, after] = [await built, await read()];
  const same = (selector) => {
    const [a, b] = [before.querySelector(selector), after.querySelector(selector)];
    return a && b && a.isEqualNode(b);
  };
  const article = document.querySelector(ARTICLE);
  if (!article || !AROUND.every(same) || after.querySelector(`${ARTICLE} .mermaid`)) {
    throw new Error('more than the article changed');
  }
  const added = [];
  patch(article, before.querySelector(ARTICLE), after.querySelector(ARTICLE), added);
  decorate(added);
  built = Promise.resolve(after);
}

// Replace the children that differ between two builds, going down the sections to the blocks
function patch(shown, before, after, added) {
  const [old, now, live] = [[...before.children], [...after.children], [...shown.children]];
  if (live.length !== old.length) throw new Error('the page no longer matches its build');
  let start = 0;
  while (start < old.length && start < now.length && old[start].isEqualNode(now[start])) start++;
  let end = 0;
  const left = () => Math.min(old.length, now.length) - start - end;
  while (left() > 0 && old.at(-1 - end).isEqualNode(now.at(-1 - end))) end++;
  const [gone, fresh] = [old.slice(start, old.length - end), now.slice(start, now.length - end)];
  const [a, b] = [gone[0], fresh[0]];
  const section = (block) => block.tagName === 'SECTION';
  if (gone.length === 1 && fresh.length === 1 && section(a) && section(b) && a.id === b.id) {
    patch(live[start], a, b, added);
    return;
  }
  const checked = gone.flatMap((_, i) => [...live[start + i].querySelectorAll('input:checked')].map((input) => input.id));
  const blocks = fresh.map((block) => document.importNode(block, true));
  gone.forEach((_, i) => live[start + i].remove());
  (live[start - 1] ?? { after: (...nodes) => shown.prepend(...nodes) }).after(...blocks);
  checked.forEach((id) => {
    const input = id && document.getElementById(id);
    if (input) input.checked = true;
  });
  added.push(...blocks);
}

// What the scripts of the page do once loaded, done again for the blocks just added
function decorate(blocks) {
  const all = (selector) => blocks.flatMap((block) => [...block.querySelectorAll(selector)]);
  if (all('div.highlight pre').length && typeof addCopyButtonToCodeCells === 'function') {
    document.querySelectorAll('.copybtn').forEach((button) => button.remove());
    addCopyButtonToCodeCells();
  }
  if (all('.sd-tab-label').length && typeof sd_id_to_elements === 'object') ready();
  all('.treeview li.collapsible > :not(ul)').forEach((item) => {
    item.addEventListener('click', (event) => {
      event.stopPropagation();
      item.closest('li.collapsible').classList.toggle('collapsed');
    });
  });
  const form = localStorage.getItem('bs-form');
  if (form && typeof showForm === 'function') all('.bs-forms').forEach((wrapper) => showForm(wrapper, form));
}

new EventSource('/__livereload/events').onmessage = (event) => {
  const change = JSON.parse(event.data);
  if (change.all) {
    location.reload();
    return;
  }
  if (change.pages.includes(page)) refresh().catch(() => location.reload());
  if (change.css) {
    document.querySelectorAll('link[rel=stylesheet]').forEach((link) => {
      const url = new URL(link.href);
      url.searchParams.set('livereload', Date.now());
      link.href = url;
    });
  }
};
