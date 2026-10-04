# 📝 Documentation

Bookshelf aims to make map making simple. Good documentation is part of that. Document every feature that you add.

---

## Write the documentation

The documentation uses Markdown with the [MyST Parser](https://myst-parser.readthedocs.io/en/latest/intro.html) extensions. Images go in the `/docs/_imgs` folder.

Each module has a page in `docs/modules`. The page name is the module name without the `bs.` prefix. For example, the page of `bs.health` is `docs/modules/health.md`. To add or change a page, follow the structure of the other pages.

---

(contribute-feature-directive)=
## Feature directive

Don't write the description, inputs, and outputs of a feature on the page. They come from the [metadata](project:metadata.md). The `{feature}` directive shows them. Add one directive for each feature, on the first line after its heading:

`````markdown
### Add levels

````{feature} bs.xp:add_levels
```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove experience from the player.
```
````

*Example: add 42 levels*

```mcfunction
function #bs.xp:add_levels.in {levels:42}
```
`````

- The content of the directive is optional. It appears after the inputs and outputs.
- If two features of different types have the same ID, write the type first: `` {feature} predicate bs.hitbox:get_entity/sized ``.

Use the rest of the page for what the metadata can't say: ideas that several features share, examples, and images.

---

## Build the documentation

To check your changes, build the documentation on your computer.

### Option 1: Build once

```shell
uv run docs build
```

This command writes the documentation to the `/docs/_build` folder.

### Option 2: Build with hot reload

```shell
uv run docs watch
```

This command builds the documentation and serves it at `http://127.0.0.1:8000`. The browser updates each time you change a page or a `module.bs` file.

---

## Translations

The translations are `.po` files in the `/docs/_locales` folder.

:::{list-table}
*   - `uv run docs locales update`
    - Update the files of every language with the latest changes
*   - `uv run docs locales add <lang>`
    - Create the files of a new language
*   - `uv run docs build --lang <lang>`
    - Build the documentation in one language
:::
