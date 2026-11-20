# 🔖 Metadata

Each module has a `module.bs` file, and each bundle has a `bundle.bs` file. These files describe the bundle, the module, and its features. The build uses them to generate the function tags, the documentation, and the editor completion. The `uv run check` command checks them. See the [validation page](project:validation.md).

```{admonition} Editor support
:class: tip

The `mcbookshelf.vscode-bsdoc` extension for VS Code highlights and checks `.bs` files.
```

---

## Syntax basics

```text
> Read and modify player XP levels.

name XP
slug bookshelf-xp
version 5.0.0
tags runtime
authors Aksiome, Leirof
since 2022/04/14 1.18.2

$updated: output state > the experience bar is updated

feature function add_levels > Add levels to players.
  @executor: player[] > players to add levels to
  input arguments
    levels: int > levels to add, negative to remove
  $updated
```

Three rules tell you what a word is:

- A word that starts a line belongs to the language, for example `feature`, `authors`, or `input`.
- A word that starts a line and has a colon right after it is yours: a field, a property, or a `$` name.
- A word that starts with `$` is defined in the file.

A colon means "is", and what follows it is on the same line: `levels: int`, `@executor: player[]`. Only a `$` name can end its line with a colon, when its lines or its properties are below.

- **Blocks**: a block is a line and the lines indented under it. Indent with two spaces. Don't use tabs.
- **Comments**: a line that starts with `#` is a comment.
- **Descriptions**: a description starts with `>` and runs to the end of the line. Write it at the end of the line it describes, or on the next line. The next lines that start with `>` continue it. A `>` alone starts a new paragraph.
- **Names**: a name uses letters, digits, `_`, and `-`. A word of the language is a valid name: a field can be named `since` or `input`.

---

## Bundle metadata

A bundle is a set of modules in one pack. Its folder name starts with `@`, for example `modules/@bs.runtime`. Its `bundle.bs` file starts with a description of the bundle. The properties follow:

```text
> A collection of all core modules, meant to ship with your datapack.

name Runtime
slug bookshelf-runtime
version 5.0.0
tags runtime
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

name Health
slug bookshelf-health
version 5.0.0
tags runtime
authors Aksiome
since 2023/09/15 1.20.2
```

| Property | Description | Required |
|----------|-------------|----------|
| name | The display name of the module, for example `Health` | yes |
| slug | The name used to publish the module, for example `bookshelf-health` | yes |
| version | The version of the module, for example `5.0.0`. See the [changelog page](project:changelog.md) | yes |
| tags | A list of tags. Bundles use them to select modules, for example `runtime` or `dev` | no |
| documentation | A link to the module documentation. The default is its page in `docs/modules` | no |
| weak_dependencies | Modules that improve this one but that it can work without, for example `bs.log` | no |

The `authors`, `since`, `deprecated`, and `experimental` lines of a feature can also go here. Each feature of the module then uses them, unless it has its own.

You don't declare dependencies. The build finds them in the module files. For example, a call to `#bs.hitbox:get_block/collision` makes the module depend on `bs.hitbox`.

---

## Feature metadata

The features come last. Declare each feature with its type, its name, and a description. The lines of the feature go under it:

```text
feature function set_health > Set players' health points.
  contributors RacoonJohn
  @executor: player[] > players to set the health of
  input arguments
    points: float @ 0..1024 > health points to set
  output state > the health is scheduled for update
```

The type is one of `function`, `predicate`, `loot_table`, `context_int_provider`, `context_float_provider`, `block_tag`, `entity_type_tag`, or `structure`.

| Line | Description | Required |
|------|-------------|----------|
| `authors A, B` | The feature authors | yes |
| `contributors A, B` | The people who helped, for example with ideas or fixes | no |
| `since 2023/09/15 1.20.2` | The date and Minecraft version when the feature was created | yes |
| `deprecated` | Users should stop using the feature | no |
| `experimental` | The feature isn't ready. Only nightly builds include it | no |

- A feature needs `authors` and `since`. It can get them from the module metadata.
- Don't write `contributors` in the module metadata. Every feature would get it, and a feature can't remove it.
- You don't write the date of the last change. The release reads it from git: it is the date of the last commit that changed the files of the feature.

Describe only what this feature does. Explain ideas that several features share on the documentation page of the module.

### Context, inputs, and outputs

These lines describe how to use the feature. They appear in the documentation, and editors use them for completion.

:::{list-table}
*   - `@executor`, `@position`, `@rotation`, `@dimension`
    - How the feature must run. A type is optional, for example `@executor: player[]`
*   - `@state`
    - A condition that the world must meet, in plain words
*   - `input arguments`
    - Data that the feature reads from the storage `<module>:<feature>`, or `<module>:<group>` in a [group](#contribute-groups), at the path `in`. Users can also [call the feature with a macro](#contribute-calling-a-feature). Optional fields, marked with `?`, go in a `with` argument
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
*   - `input state`, `output state`
    - Anything else that the feature reads or changes, in plain words
:::

Write the fields of an input or an output under its line. To give it another type, write the type after a colon, for example `output storage: float @ 0..1`. Don't end the line with a colon.

A feature declares `input arguments` or `input macro`, not both.

Not every type accepts every line:

| Type | Context | Inputs | Outputs |
|------|---------|--------|---------|
| `function` | all | `arguments`, `macro`, `storage`, `state` | `result`, `success`, `storage`, `state` |
| `predicate` | all | `storage`, `state` | `success`, required |
| `loot_table` | all | `storage`, `state` | `state` |
| `context_int_provider`, `context_float_provider` | all | `storage`, `state` | `result`, required |
| `block_tag`, `entity_type_tag`, `structure` | none | none | none |

The features of a group share their storage without a name. The build reports a group whose features declare different input or output storages.

To use another storage, name it before the colon:

```text
output storage bs.<module>:<name> out: [[double] @ 7]
```

### Types

| Type | Written |
|------|---------|
| Numbers | `byte`, `short`, `int`, `long`, `float`, `double`, `number` |
| Others | `boolean`, `string`, `any` |
| Context only | `entity`, `player`, `xyz`, `xy`, `overworld`, `nether`, `end` |
| Array | `int[]`, `byte[]`, `long[]`. A context also takes `entity[]` and `player[]` |
| List | `[T]` |
| Tuple | `[T, U]` |
| Union | `T \| U` |
| Struct | `struct`, with its fields indented under the line |
| Your own | `$name` |

- **Ranges**: `@` gives the range of a number, or the length of a string, a list, or an array. For example `int @ 0..`, `float @ 0..1`, or `[int] @ 3`. A `<` on a side excludes that bound: `number @ 0<..1`.
- **Attributes**: an mcdoc attribute can go before a type, for example `#[id(registry="function")] string`.

A struct is a set of fields indented under a line. A field is `name: type > description`, and it always has a type. Add `?` after the name of an optional field:

```text
input arguments
  run: string > command to run at each point
  limits: struct
    batch?: int @ 1.. > blocks placed each tick
  points: [struct] @ 2.. > points of the path, in order
    at: [int] @ 3
    wait?: int @ 0..
```

- The fields under a line belong to the `struct` in its type: `limits: struct`, `[struct] @ 2..`, or `struct | number`.
- An input or an output without a type takes the fields under it directly.
- A line has only one `struct`, because only one block of fields follows it.

---

## Definitions

A definition is a `$` name. Use it to write something only once. Put the definitions after the module metadata and before the features.

| Written | It is | Use it |
|---------|-------|--------|
| `$name: type > description` | A type | As a type |
| `$name: struct` then fields | A struct | As a type, or alone on a line between other fields to add its fields |
| `$name:` then feature lines | Lines | Alone on a line of a feature |
| `$name: line` | One line | Alone on a line of a feature |
| `$name[item]:` then properties | A list | In the name of a feature. See [repeated features](#contribute-repeated-features) |

```text
$max_distance: number @ 0..2047 > distance the ray travels at most, 16 by default

$position: struct
  x: int
  y: int
  z: int

$ray:
  contributors Bafy78
  @position > origin of the ray
  @rotation > direction of the ray

$updated: output state > the experience bar is updated

feature function cast > Cast a ray and check if it hits a block or an entity.
  since 2023/10/09 1.20.2
  $ray
  input arguments
    max_distance?: $max_distance
    from?: $position
  output success > whether a block or an entity stops the ray
```

- A field that uses a type and has no description takes the description of the type.
- The block under `$name:` has feature lines. Put fields under `$name: struct`.
- `$a: $b` is a type. To reuse the lines of `$b`, write `$b` in a block.

A feature gets its lines from three places. A later line replaces the same line from an earlier place:

1. The module metadata.
2. The lines of the definitions that it uses, in order.
3. Its own lines.

Two lines are the same when they have the same word, for example `since` or `@position`, or the same kind and storage, for example `input arguments`. Two structs are merged instead: the feature gets the fields of both.

(contribute-repeated-features)=
### Repeated features

A list is a set of items. Each item can have properties. A property is `key: text`, and the text runs to the end of the line:

```text
$axis[x]:
  side: west
$axis[y]:
  side: bottom
$axis[z]:
  side: north

$point[entry, exit]

feature context_float_provider $point/$axis > Get the $axis coordinate of the point.
  since 2026/10/19 26.3
  output result: float > $axis coordinate in blocks, from the $axis.side side of the block
```

A feature with a list in its name exists once for each item. This example declares six features: `entry/x`, `entry/y`, `entry/z`, `exit/x`, `exit/y`, and `exit/z`.

- The build replaces `$list` with the item, and `$list.key` with the property of the item.
- It replaces them in the name of the feature, in the descriptions, and in the `authors`, `contributors`, and `since` lines.
- You can only use a list in a feature that has it in its name.
- Each item must have the properties that you use.
