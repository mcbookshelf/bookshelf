// Served only by `docs watch`: reload a rebuilt page, with the tabs that were open on it.
// The browser puts the scroll back itself. Stylesheets are swapped in place.
const page = (location.pathname.replace(/^\//, '').replace(/\/$/, '/index') || 'index').replace(/\.html$/, '');
const KEPT = 'livereload';

// Open the tabs again: a reload goes back to the first one of each set
const kept = JSON.parse(sessionStorage.getItem(KEPT) ?? 'null');
sessionStorage.removeItem(KEPT);
if (kept?.page === page) {
  kept.checked.forEach((id) => {
    const input = document.getElementById(id);
    if (input) input.checked = true;
  });
}

function reload() {
  const checked = [...document.querySelectorAll('input:checked')].map((input) => input.id).filter(Boolean);
  sessionStorage.setItem(KEPT, JSON.stringify({ page, checked }));
  location.reload();
}

new EventSource('/__livereload/events').onmessage = (event) => {
  const change = JSON.parse(event.data);
  if (change.all || change.pages.includes(page)) {
    reload();
    return;
  }
  if (change.css) {
    document.querySelectorAll('link[rel=stylesheet]').forEach((link) => {
      const url = new URL(link.href);
      url.searchParams.set('livereload', Date.now());
      link.href = url;
    });
  }
};
