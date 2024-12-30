# 📝 Documentation

Bookshelf aims to simplify map making and make it accessible. We’ve worked hard to create a comprehensive documentation website and ask that every new feature be documented properly.

---

## ✍️ Write the Documentation

The documentation is written in Markdown, extended with Myst Parser. You can view the [Myst Parser documentation here](https://myst-parser.readthedocs.io/en/latest/intro.html). To add or update documentation, simply follow the structure of existing pages and features. All images are stored in the `/docs/_imgs` folder.

---

## 🔨 Build the Documentation

To verify that your documentation changes work as expected, you can build and view it locally on your computer.
1. Open a terminal (or Powershell if you are on Windows).
2. Choose one of the following options to build and view the documentation:

### Option 1: Build Documentation

```shell
pdm run docs build
```

This command will generate the documentation, which you can find in the `/docs/_build` folder.

### Option 2: Build with Hot Reload

```shell
pdm run docs watch
```

This option will also generate the documentation but will allow you to view it in your browser at `http://127.0.0.1:8000` with hot reloading, so any changes you make will automatically update in the browser.
