const getTheme = () => {
  const theme = document.documentElement.dataset.theme;
  return (theme === "light" || theme === "dark") ? theme : (
    window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  )
}

const observer = new MutationObserver((mutations) => {
  const sendMessage = (message) => {
    const iframe = document.querySelector('iframe.giscus-frame');
    if (iframe) {
      iframe.contentWindow.postMessage({ giscus: message }, 'https://giscus.app');
    }
  }
  sendMessage({ setConfig: { theme: getTheme() } });
});

observer.observe(document.documentElement, {attributes: true, attributeFilter: ['data-theme']});

document.addEventListener('DOMContentLoaded', () => {
  const comments = document.getElementById('gs-comments');
  if (comments) {
    const giscusAttributes = {
      "src": "https://giscus.app/client.js",
      "data-repo": "mcbookshelf/Bookshelf",
      "data-repo-id": "R_kgDOHQjqYg",
      "data-category": "Documentation",
      "data-category-id": "DIC_kwDOHQjqYs4CUQpy",
      "data-mapping": "title",
      "data-strict": "0",
      "data-reactions-enabled": "1",
      "data-emit-metadata": "0",
      "data-input-position": "bottom",
      "data-theme": getTheme(),
      "data-lang": "en",
      "crossorigin": "anonymous",
      "async": "",
    };

    const giscusScript = document.createElement("script");
    Object.entries(giscusAttributes).forEach(([key, value]) => giscusScript.setAttribute(key, value));
    comments.appendChild(giscusScript);
  }
});
