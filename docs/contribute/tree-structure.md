---
html_theme.sidebar_secondary.remove: true
---

# 🌳 Tree Structure

Bookshelf respects a certain tree structure which can be similar to Java packages, called "modules" in this project. The added features must therefore be positioned in these various modules according to their usefulness.

---

:::::{grid} 1 2 2 2
::::{grid-item}
:columns: 12 6 6 7

**Module Requirements:**

- Each module must include a `module.json`, as described in the [metadata page](project:metadata.md).

- Each module must also include a `pack.png` and a `README.md`.

- The `__load__` and `__unload__` functions are required to manage the module's loading and unloading. This includes resetting objectives, storages, and any other necessary elements.


**Feature Requirements:**

- Each feature function should have a dedicated function tag that declares metadata, as detailed in the [metadata page](project:metadata.md).

- Each feature should declares metadata, as detailed in the [metadata page](project:metadata.md).

- A feature is equal to a unique utility, so we should not hesitate to decompose its features in order to make it more readable and to promote reusability.

In addition to these few constraints, contributors are free to organize their files as they wish as long as it remains coherent and it respects the global structure.
::::
::::{grid-item}
:columns: 12 6 6 5

:::{treeview}
- {mcdir}`folder` modules
  - {mcdir}`folder` \<module\>
    - {mcdir}`folder` data/\<module\>
      - {mcdir}`folder` function
        - {mcdir}`folder` \<feature1\>
          - {mcdir}`mcfunction` ...
        - {mcdir}`mcfunction` \<feature2\>.mcfunction
        - {mcdir}`mcfunction` \_\_load\_\_.mcfunction
        - {mcdir}`mcfunction` \_\_unload\_\_.mcfunction
      - {mcdir}`folder` \<predicate|loot_table|...\>
        - {mcdir}`json` \<feature1\>.json
        - {mcdir}`json` ...
      - {mcdir}`folder` tags/function
        - {mcdir}`json` \<feature1\>.json
        - {mcdir}`json` ...
    - {mcdir}`json` module.json
    - {mcdir}`image` pack.png
    - {mcdir}`file` README\.md
  - {mcdir}`folder` ...
:::
::::
:::::
