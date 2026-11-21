# 🌳 Tree structure

A module is a folder in `modules/`. Its name is its namespace, for example `bs.health`. This page explains what goes in that folder and how to name the files.

---

:::::{grid} 1 2 2 2
::::{grid-item}
:columns: 12 6 6 7

**Module requirements:**

- A `module.bs` file. See the [metadata page](project:metadata.md).
- A `CHANGELOG.md` file. See the [changelog page](project:changelog.md).
- A `README.md` file and a `pack.png` image.

**Feature requirements:**

- Declare each feature in `module.bs`.
- Give each function feature its own folder, with a `__main__` function.
- Name any other feature file after the feature. This applies to predicates, tags, and number providers.
- Keep each feature small. Split a feature that does several things.

Apart from these rules, organize your files as you like. Keep the result consistent.
::::
::::{grid-item}
:columns: 12 6 6 5

:::{treeview}
- {mcdir}`folder` \<module\>
  - {mcdir}`folder` data/\<module\>
    - [+] {mcdir}`folder` function
      - [+] {mcdir}`folder` \<feature\>
        - {mcdir}`mcfunction` \_\_main\_\_.mcfunction
        - {mcdir}`mcfunction` \_\_macro\_\_.mcfunction
        - {mcdir}`mcfunction` ...
      - [-] {mcdir}`folder` \<group\>
        - {mcdir}`folder` \<feature\>
          - {mcdir}`mcfunction` \_\_main\_\_.mcfunction
        - {mcdir}`mcfunction` ...
      - {mcdir}`mcfunction` \_\_load\_\_.mcfunction
      - {mcdir}`mcfunction` \_\_unload\_\_.mcfunction
    - [-] {mcdir}`folder` \<predicate|loot_table|...\>
      - {mcdir}`folder` \_\<feature\>
        - {mcdir}`json` ...
      - {mcdir}`json` \<feature\>.json
    - [-] {mcdir}`folder` test
      - {mcdir}`mcfunction` \<feature\>.mcfunction
  - {mcdir}`file` module\.bs
  - {mcdir}`file` CHANGELOG\.md
  - {mcdir}`file` README\.md
  - {mcdir}`image` pack.png
:::
::::
:::::

---

## Features and groups

A function feature is a folder. Put every file that only this feature uses in its folder:

```text
function/set_ttl/__main__.mcfunction    run by #bs.health:set_ttl
function/set_ttl/__macro__.mcfunction   run by #bs.health:set_ttl.in
function/set_ttl/check.mcfunction       used only by set_ttl
```

The build generates the function tags from `module.bs`. Don't write `tags/function/<feature>.json` yourself.

A **group** is a folder that contains several features. In `bs.hitbox`, `get_block` is a group. It holds `get_block/collision`, `get_block/outline`, and other features. Put the files that only these features use in the group folder. A feature can't also be a group.

The features of a group must take the same inputs and write the same outputs. They [share the storage of the group](#contribute-groups). Don't use a group only to sort features that have close names.

Any file outside a feature folder or a group folder is shared. The whole module can use it.

---

(contribute-reserved-names)=
## Reserved names

A function name with double underscores on each side has a special meaning. You can't give such a name to a feature.

:::{list-table}
*   - `__main__`
    - The function that the feature tag runs: `#<module>:<feature>`
*   - `__macro__`
    - The function that the `.in` tag runs: `#<module>:<feature>.in`. The build generates it for `input arguments`, unless you write it
*   - `__load__`
    - The function that runs when the module loads. The build generates it if it's missing
*   - `__unload__`
    - The function that runs when the module unloads. The build generates it if it's missing
*   - `__help__`
    - The function that links to the module documentation. The build always generates it
:::

(contribute-load-and-unload)=
### Load and unload

The build removes the storages that you declare in `module.bs`. Remove any other data yourself.

A feature or a group can have its own `__load__` and `__unload__` functions in its folder. They run after the functions of the module.

---

(contribute-public-and-private-files)=
## Public and private files

Users call a function through the function tag of its feature. A function needs no marker. Never add a `_` prefix to a function.

Users can call any other file by its ID. This applies to predicates, tags, number providers, and advancements. Each of these files is either public or private:

- **Public**: declare the file as a feature in `module.bs`.
- **Private**: add a `_` prefix to the file name or to one of its folders.

For example:

```text
predicate/get_entity/sized.json            public, the feature get_entity/sized
predicate/_set_ttl/check.json              private to the feature set_ttl
tags/block/_get_block/interaction.json     private to the group get_block
advancement/_on_heal.json                  private to the module
```
