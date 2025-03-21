:::{list-table} General Concepts
*   - **Bundle**
    - A set of modules packaged together for distribution.
*   - **Dependency**
    - A module that another module relies on to function properly. It must be loaded for the dependent module to work.
*   - **Feature**
    - A user-facing element designed to accomplish a task. Features are often represented as function tags, but can also include loot tables, structures, predicates, and more.
*   - **Module**
    - A collection of related features within a namespace, serving a specific purpose.
*   - **Weak Dependency**
    - An optional dependency that enhances functionality if present, but is not essential for the main module to function correctly.
:::

:::{list-table} Special Arguments
*   - **`on_*`**
    - Specifies a command to be executed by a feature when a particular event occurs.
*   - **`run`**
    - Specifies a command to be executed by a feature, often immediately.
*   - **`with`**
    - Specifies optional arguments.
:::

:::{list-table} Special Functions
*   - **`*_ata`**
    - Shortened from "as to at." These functions take two positions: one given through a positional argument (e.g., `positioned`, `at`), and the other from the executor's position.
:::
