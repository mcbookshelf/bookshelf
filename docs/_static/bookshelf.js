const getTheme = () => {
  const theme = document.documentElement.dataset.theme;
  return (theme === "light" || theme === "dark") ? theme : (
    window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  )
}

const observer = new MutationObserver(() => {
  const sendMessage = (message) => {
    const iframe = document.querySelector('iframe.giscus-frame');
    if (iframe) {
      iframe.contentWindow.postMessage({ giscus: message }, 'https://giscus.app');
    }
  }
  sendMessage({ setConfig: { theme: getTheme() } });
});

observer.observe(document.documentElement, {attributes: true, attributeFilter: ['data-theme']});

function initGiscus() {
  const comments = document.getElementById('gs-comments');
  if (comments) {
    const giscusAttributes = {
      src: 'https://giscus.app/client.js',
      'data-repo': 'mcbookshelf/bookshelf',
      'data-repo-id': 'R_kgDOHQjqYg',
      'data-category': 'Documentation',
      'data-category-id': 'DIC_kwDOHQjqYs4CUQpy',
      'data-mapping': 'title',
      'data-strict': '0',
      'data-reactions-enabled': '1',
      'data-emit-metadata': '0',
      'data-input-position': 'bottom',
      'data-theme': getTheme(),
      'data-lang': 'en',
      crossorigin: 'anonymous',
      async: '',
    };

    const giscusScript = document.createElement('script');
    Object.entries(giscusAttributes).forEach(([key, value]) => {
      giscusScript.setAttribute(key, value);
    });
    comments.appendChild(giscusScript);
  }
}

if (document.readyState === 'complete') {
  initGiscus();
} else {
  window.addEventListener('load', initGiscus);
}

const FORM_KEY = 'bs-form';

function showForm(wrapper, form) {
  wrapper.classList.remove('bs-show-storage', 'bs-show-macro');
  wrapper.classList.add(`bs-show-${form}`);
  wrapper.querySelectorAll('.bs-switch button').forEach((button) => {
    button.setAttribute('aria-pressed', button.dataset.form === form);
  });
}

function initForms() {
  const saved = localStorage.getItem(FORM_KEY);
  if (saved) {
    document.querySelectorAll('.bs-forms').forEach((wrapper) => showForm(wrapper, saved));
  }
  document.addEventListener('click', (event) => {
    const button = event.target.closest('.bs-switch button');
    if (!button) return;
    const form = button.dataset.form;
    localStorage.setItem(FORM_KEY, form);
    document.querySelectorAll('.bs-forms').forEach((wrapper) => showForm(wrapper, form));
  });
}

initForms();
