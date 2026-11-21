# 📋 Changelog

Each module has its own `CHANGELOG.md` file. It tells users what changed. It also sets the next version of the module.

---

## Format

```markdown
# ❤️ Health

## Unreleased

- 🐛 Fixed health updates when using percentage-based max health attributes ([#428](https://github.com/mcbookshelf/bookshelf/pull/428))

## `v3.0.1`

- 🐛 Ensured player health updates consistently ([#410](https://github.com/mcbookshelf/bookshelf/issues/410))
```

- Keep the `## Unreleased` section at the top. Add one line there for each change.
- Start each line with an emoji. Describe the change for users. Link the issue or the pull request.
- Don't add version sections, such as `` ## `v1.0.0` ``. The release process creates them.

---

## Entry types

:::{list-table}
*   - `⚠️`
    - A breaking change. Users must update their code
*   - `✨`
    - A new feature
*   - `♻️`
    - A change to an existing feature that breaks nothing
*   - `🐛`
    - A bug fix
*   - `⚡`
    - A performance improvement
*   - `🗑️`
    - A deprecated feature
*   - `📝`
    - A documentation change
*   - `⚙️`
    - Any other change
:::

The emojis also set the next version of the module. See [version bumps](#contribute-version-bumps).
