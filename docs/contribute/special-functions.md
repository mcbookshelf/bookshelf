# 🌟 Special Functions

Some functions follow specific conventions to streamline functionality and ensure consistency across modules.

---

## 👉 The `ata` Functions

This is a reduction of "as to at". Several functions require two positions to work (example: retrieve the distance between 2 points) or an entity and a position. To simplify the use, no need to pass 3 scores for each position. You will be able to place an entity on point 1 (if it is useful), then execute the function at point 2 while executing it as the entity on point 1.

---

## 🔗 The `runner` Functions

These functions use the `run` callback to specify an action that will often be executed immediately. It works like a subcommand, defining what action should take place after the function call.

For example:
```mcfunction
function #bs.view:at_aimed_block {run: "<command>", with: {}}
```

---

## 📡 The `listener` Functions

These functions are designed to react to specific events. The naming convention `on_<event>` is used for the inputs to indicate commands that will be triggered when a particular event occurs.

For example:
```mcfunction
function #bs.health:time_to_live {with: {on_death: "<command>", time: 10}}
```

---

## ⚒️ The `callback` Functions

These functions are intended to be executed exclusively as part of a callback, and their function tag must be placed inside a `callback` directory.

For example:
- `#bs.move:callback/bounce`
- `#bs.move:callback/slide`
- `#bs.interaction:callback/glow`

---

## 🔒 The `reserved` Functions

Reserved functions are special functions within each module that serve predefined purposes. They are located at the root of each module.

:::{list-table}
*   - `__help__`
    - This function provides a path to the documentation for the module. **(Automatically generated)**
*   - `__load__`
    - This function is executed when the module is loaded. **(Must be present in every module)**
*   - `__unload__`
    - This function is executed when the module is unloaded. **(Must be present in every module)**
:::
