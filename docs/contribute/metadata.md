# 🔖 Metadata

Each module has a `module.bs` file, and each bundle has a `bundle.bs` file. These files describe the bundle, the module, and its features. The build uses them to generate the function tags, the documentation, and the editor completion. The `uv run check` command checks them. See the [validation page](project:validation.md).

This page covers the basics. To learn more of the syntax, read the `module.bs` files of other modules.

```{admonition} Editor support
:class: tip

The `mcbookshelf.vscode-bsdoc` extension for VS Code highlights and checks `.bs` files.
```

---

## Bundle metadata

A bundle is a set of modules in one pack. Its folder name starts with `@`, for example `modules/@bs.runtime`. Its `bundle.bs` file starts with a description of the bundle. The properties follow:

```text
> A collection of all core modules, meant to ship with your datapack.

name: Runtime
slug: bookshelf-runtime
version: 5.0.0
tags: runtime
```

| Property | Description | Required |
|----------|-------------|----------|
| name | The display name of the bundle, for example `Runtime` | yes |
| slug | The name used to publish the bundle, for example `bookshelf-runtime` | yes |
| version | The version of the bundle, for example `5.0.0` | yes |
| tags | A list of tags. The bundle includes every released module that has one of them | yes |
| documentation | A link to the bundle documentation | no |

---

## Module metadata

The `module.bs` file starts with a description of the module. The properties follow:

```text
> Read and modify player health, and give entities a lifetime.

name: Health
slug: bookshelf-health
version: 5.0.0
tags: runtime
```

| Property | Description | Required |
|----------|-------------|----------|
| name | The display name of the module, for example `Health` | yes |
| slug | The name used to publish the module, for example `bookshelf-health` | yes |
| version | The version of the module, for example `5.0.0`. See the [changelog page](project:changelog.md) | yes |
| tags | A list of tags. Bundles use them to select modules, for example `runtime` or `dev` | no |
| documentation | A link to the module documentation. The default is its page in `docs/modules` | no |
| weak_dependencies | Modules that improve this one but that it can work without, for example `bs.log` | no |

You don't declare dependencies. The build finds them in the module files. For example, a call to `#bs.hitbox:get_block/collision` makes the module depend on `bs.hitbox`.

---

## Feature metadata

The features come after the module properties. Declare each feature with its type, its name, and a description:

```text
feature function set_health
  > Set players' health points.
  authors: Aksiome
  contributors: RacoonJohn
  created: 2023/09/15 1.20.2
  updated: 2026/09/20 26.3

  context executor: player[] > players to set the health of
  input arguments: {
    points: float @ 0..1024 > health points to set
  }
  output state > the health is scheduled for update
```

The type is one of `function`, `predicate`, `loot_table`, `context_int_provider`, `context_float_provider`, `block_tag`, or `entity_type_tag`.

| Property | Description | Required |
|----------|-------------|----------|
| authors | A list of the feature authors | yes |
| contributors | A list of people who helped, for example with ideas or fixes | no |
| created | The date and Minecraft version when the feature was created | yes |
| updated | The date and Minecraft version of the last change | yes |
| deprecated | Set to `true` when users should stop using the feature | no |
| experimental | Set to `true` when the feature isn't ready. Only nightly builds include it | no |

A description starts with `>`. Describe only what this feature does. Explain ideas that several features share on the documentation page of the module.

### Context, inputs, and outputs

The lines that start with `context`, `input`, and `output` describe how to use the feature. They appear in the documentation, and editors use them for completion.

:::{list-table}
*   - `context`
    - How the feature must run: `executor`, `position`, `rotation`, or `dimension`
*   - `input arguments`
    - Data that the feature reads from the storage `<module>:<feature>`, or `<module>:<group>` in a [group](#contribute-groups), at the path `in`. Users can also [call the feature with a macro](#contribute-calling-a-feature). Optional entries, marked with `?`, go in a `with` argument
*   - `input storage`
    - Same as `input arguments`, without the macro
*   - `input macro`
    - The arguments of a `__macro__` function that you write
*   - `output storage`
    - Data that the feature writes to the storage `<module>:<feature>`, or `<module>:<group>` in a [group](#contribute-groups), at the path `out`
*   - `output result`
    - The number that the feature returns
*   - `output success`
    - The feature either succeeds or fails
*   - `state`
    - Anything else, in plain words. Use it after `context`, `input`, or `output`
:::

The features of a group share their storage without a name. The build reports a group whose features declare different input or output storages.

To use another storage, name it:

```text
output storage bs.<module>:<name> out: [[double] @ 7]
```
