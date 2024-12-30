---
html_theme.sidebar_secondary.remove: true
---

# 📖 Definitions

In order to speak with the same vocabulary, here is some words that have a specific meaning in this project:

---

:::{list-table}
*   - **Brigadier**
    - This is the command parser and dispatcher used by Minecraft. For example, it's used for autocompletion when you enter a command in the chat. We define it here because most people don't know that this system has a name.
*   - **Dependency**
    - A module that another module relies on for functionality. It must be loaded for the dependent module to work correctly.
*   - **Feature**
    - Something designed for the final user in order to allow them to perform a task. Most of the time, a feature is a function tag to call instead of the function. A feature can also be a loot table, a structure, a predicate or whatever.
*   - **Module**
    - A group of features that share a common purpose and that are contained in a namespace (i.e. datapack structures).
*   - **Weak Dependency**
    - A type of dependency that is optional. If present, it provides additional functionality, but its absence does not prevent the main module from functioning correctly.
:::
