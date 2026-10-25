# ✅ Validation

A contribution is more than code. The `check` command checks that a module follows the project rules:

```sh
# Check every module
uv run check

# Check only the modules you name
uv run check <module1> ...
```

The command shows each issue with its file and line. Most messages tell you how to fix the issue. The command also runs on every pull request, with the [tests](project:testing.md).

---

## What the command checks

:::{list-table}
*   - **Metadata**
    - The `module.bs` file is valid. If it has errors, the command shows only these errors. See the [metadata page](project:metadata.md)
*   - **Layout**
    - The module has its required files. Each function starts with the [license header](#contribute-license-header). Each file is a declared feature or a [private file](#contribute-public-and-private-files)
*   - **References**
    - Each Bookshelf ID in a file belongs to a known feature. No feature uses the private files of another feature
*   - **Changelog**
    - The [changelog](project:changelog.md) has an `Unreleased` section. It has a line for each change since the last release
*   - **Documentation**
    - The module has a documentation page. Each feature has its [feature directive](#contribute-feature-directive)
:::

---

## Messages that need more detail

| Message | Fix |
|---------|-----|
| 'x' cannot be attributed: the feature part is dynamic | A macro builds the ID. Write enough of the ID to identify the feature |
| 'x' cannot be attributed: the static part could name a feature or a shared path | Same as the previous message. The written part matches several features |
| 'x' changed since v1.0.0: update its 'updated' stamp | Set the `updated` property of the feature to today's date and the current Minecraft version |
