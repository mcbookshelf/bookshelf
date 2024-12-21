---
html_theme.sidebar_secondary.remove: true
---

# 🏷️ Nomenclature

Bookshelf respects certain naming conventions in order to reduce the effort needed to read and understand code.

---

:::{list-table}
*   - **Files**
    - Use the snake_case convention. A few names are reserved for [special functions](project:../contribute/special-functions.md) at the root of each module: `__help__`, `__load__`, and `__unload__`.

      *Example: `function/<my_function>.mcfunction`*
*   - **Entity tags**
    - Use the snake_case convention. Must be prefixed with `bs.` and the name of the module.

      *Example: `bs.<module>.my_tag`*
*   - **Data storage**
    - Use the snake_case convention. Is limited to what is defined in the [Shared Resources](project:shared-resources.md) section.

      *Example: `bs:data <module>.<feature>`*
*   - **Objectives**
    - Use the snake_case convention and `bs.` prefix. Only create new objectives if no existing objective defined in the [Shared Resources](project:shared-resources.md) section can be used.

      *Example: `bs.my_objective`*
*   - **Scoreholders**
    - Use the snake_case convention. Must be prefixed with the name of the module. Each score should also be prefixed by either `#` for private scores or `$` for public ones.

      *Example: `$<module>.debug` or `#<module>.any`*
:::
