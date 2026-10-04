:::{list-table} General concepts
*   - **Bundle**
    - A set of modules packaged together for distribution.
*   - **Dependency**
    - A module that another module relies on to function properly. It must be loaded for the dependent module to work.
*   - **Feature**
    - A user-facing element designed to accomplish a task. Features are often represented as function tags, but can also include predicates, number providers, loot tables, tags, and more.
*   - **Module**
    - A collection of related features within a namespace, serving a specific purpose.
*   - **Weak Dependency**
    - An optional dependency that enhances functionality if present, but is not essential for the main module to function correctly.
:::

:::{list-table} Special arguments
*   - **`run`**
    - Specifies a command to be executed by a feature.
*   - **`with`**
    - Groups the optional arguments of a feature called with a macro.
:::

:::{list-table} Special functions
*   - **`*.in`**
    - The function tag that takes the inputs of a feature as macro arguments, instead of reading them from its storage.
*   - **`*_ata`**
    - Shortened from "as to at." These functions take two positions: one given through a positional argument (e.g., `positioned`, `at`), and the other from the executor's position.
:::
