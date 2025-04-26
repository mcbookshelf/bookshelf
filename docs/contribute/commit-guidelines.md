# 📋 Commit Guidelines

This section is meant for maintainers. Contributors do not need to worry about commit messages as PRs are squash-merged before being integrated into the project.

---

## ✍️ Commit Format

We follow **Conventional Commits** to standardize commit messages, making it easier to understand the purpose of each change. Commit messages should include an **emoji** to indicate the type of change and follow the format below:

```html
<type>[(<scope>)]: <message>
```

For breaking changes, add a `!` after the type or scope.

---

## 🗂️ Commit Types

:::{list-table}
*   - `✨ feat`
    - Adds a new feature or significant functionality
*   - `🐛 fix`
    - Corrects a bug or malfunction
*   - `⚡️ perf`
    - Optimizes code to improve performance
*   - `♻️ refactor`
    - Restructures existing code without changing its behavior
*   - `🎨 style`
    - Updates code style without affecting behavior (e.g., formatting, spacing)
*   - `📝 docs`
    - Changes or improves project documentation
*   - `🧪 test`
    - Adds new tests or updates existing ones
*   - `🔨 build`
    - Updates to scripts responsible for building project parts
*   - `⚙️ ci`
    - Changes to continuous integration workflows or scripts
*   - `🛠️ chore`
    - Routine tasks like version bumps, metadata updates, or asset maintenance
:::

---

## 🎯 Using Scopes

Commit messages can include a **scope** to specify which part of the project is affected. Example:

```
📝 docs(bs.block): update get_block output
```

---

## ⚠️ Breaking Changes

If a change introduces a **breaking change**, add a `!` after the type or scope. Example:

```
✨ feat(bs.block)!: add a new macro argument to the replace_type function
```

This helps ensure that users are aware of any changes that might affect compatibility.
