# 📄 Log

**`#bs.log:help`**

Log messages in the chat with varying levels of severity.

```{admonition} Enable Command Blocks
:class: warning

This module uses a command block to get the system time. For the time to be displayed as intended, be sure that `enable-command-block` is set to `true` in your `server.properties` file and that the `sendCommandFeedback` gamerule is enabled.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Log Messages

:::::{tab-set}
::::{tab-item} Error

```{function} #bs.log:error

Log an error message. For more information on how it works see the [usage](#usage) section. By default, it's printed as: [ERROR] <tag> > <message> and hovering over the left part of the log reveals the timestamp and log function path.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **message**: Logged message. Must be a valid SNBT text component.
    - {nbt}`string` **namespace**: Namespace of the function.
    - {nbt}`string` **path**: Origin path for the log (current Minecraft function).
    - {nbt}`string` **tag**: A tag to identify the function. This tag is displayed in the log message and is used as group to manage the granularity.
  :::
```

*Example: Log an error message that originates from the `bs.foo:bar` function:*

```mcfunction
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Error"' }
```

::::
::::{tab-item} Warning

```{function} #bs.log:warn

Log a warning message. For more information on how it works see the [usage](#usage) section. By default, it's printed as: [WARN] <tag> > <message> and hovering over the left part of the log reveals the timestamp and log function path.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **message**: Logged message. Must be a valid SNBT text component.
    - {nbt}`string` **namespace**: Namespace of the function.
    - {nbt}`string` **path**: Origin path for the log (current Minecraft function).
    - {nbt}`string` **tag**: A tag to identify the function. This tag is displayed in the log message and is used as group to manage the granularity.
  :::
```

*Example: Log a warning message that originates from the `bs.foo:bar` function:*

```mcfunction
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Warning"' }
```

::::
::::{tab-item} Information

```{function} #bs.log:info

Log an information message. For more information on how it works see the [usage](#usage) section. By default, it's printed as: [INFO] <tag> > <message> and hovering over the left part of the log reveals the timestamp and log function path.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **message**: Logged message. Must be a valid SNBT text component.
    - {nbt}`string` **namespace**: Namespace of the function.
    - {nbt}`string` **path**: Origin path for the log (current Minecraft function).
    - {nbt}`string` **tag**: A tag to identify the function. This tag is displayed in the log message and is used as group to manage the granularity.
  :::
```

*Example: Log an info message that originates from the `bs.foo:bar` function:*

```mcfunction
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Info"' }
```

::::
::::{tab-item} Debug

```{function} #bs.log:debug

Log a debug message. For more information on how it works see the [usage](#usage) section. By default, it's printed as: [DEBUG] <tag> > <message> and hovering over the left part of the log reveals the timestamp and log function path.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **message**: Logged message. Must be a valid SNBT text component.
    - {nbt}`string` **namespace**: Namespace of the function.
    - {nbt}`string` **path**: Origin path for the log (current Minecraft function).
    - {nbt}`string` **tag**: A tag to identify the function. This tag is displayed in the log message and is used as group to manage the granularity.
  :::
```

*Example: Log a debug message that originates from the `bs.foo:bar` function:*

```mcfunction
function #bs.log:debug { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Debug"' }
```

::::
:::::

> **Credits**: theogiraudet

---

### Log History

:::::{tab-set}
::::{tab-item} View History

```{function} #bs.log:history {with:{}}

Retrieve the log history. It shows all the previously logged messages.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Optional filters.
      - {nbt}`string` **severity**: Severity level to filter logs (`error`, `warn`, `info`, or `debug`).
      - {nbt}`string` **namespace**: Namespace to filter the logs.
      - {nbt}`string` **tag**: Tag to filter logs.
  :::
```

*Example: View the log history for a specific namespace, tag, and severity level:*

```mcfunction
# Once
function #bs.log:history {with: {severity: "warn", namespace: "bs.foo", tag: "bar"}}
```

::::
::::{tab-item} Clear History

```{function} #bs.log:clear_history {with:{}}

Clear the log history.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Optional filters.
      - {nbt}`string` **severity**: Severity level to filter logs (`error`, `warn`, `info`, or `debug`).
      - {nbt}`string` **namespace**: Namespace to filter the logs.
      - {nbt}`string` **tag**: Tag to filter logs.
  :::
```

*Example: Clear the log history for a specific namespace, tag, and severity level:*

```mcfunction
# Once
function #bs.log:clear_history {with: {severity: "warn", namespace: "bs.foo", tag: "bar"}}
```

::::
:::::

> **Credits**: Aksiome

---

(usage)=
## 🎓 How to Use?

Different log levels are available for various types of logs:
1. **Debug**: Detailed debug information.
2. **Information**: Interesting / significant events.
3. **Warning**: Exceptional occurrences that are not errors.
4. **Error**: Runtime errors that should be monitored and fixed.

---

### Manage Granularity

A significant number of logs can quickly flood the chat. To prevent this, Bookshelf's log module can be configured to display specific logs based on two parameters: the **log level**, the **tag** and the **namespace**.

Users need to give themselves tags that follow a strict syntax: `<namespace>.log.<tag>.<level>`, where the level can be `debug`, `info`, `warn`, or `error`.

The `_` symbol acts as a wildcard, logging all tags or all levels:
- `bs.foo.log._.<level>`: show all logs of `bs.foo` regardless of the tag.
- `bs.foo.log.<tag>._`: show all logs of `bs.foo` regardless of the level.
- `bs.foo.log._._`: show all logs of `bs.foo`.
- `_.log._._`: show all logs.

```{note}
Each level allows the visualization of subsequent levels. For example, if a user gives themselves a tag ending with warn, they can visualize logs of warn and error levels. By default, logs are not displayed to any user.
```

---

### Define the Message

Log functions take four variables as input. The `path` of the current function that inform users of the log origin, the `tag`, the `namespace` and the `message`.

```{warning}
The `message` string must be a valid SNBT text component. Thus, to specify a plain string text as a message, the message needs to be escaped  (`"\"message\""` or `'"message"'`).
```

*Example: Log a simple warning message. We assume the log originates from the `bs.foo:bar` function:*

```mcfunction
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"A warning message"' }
```

Will display the following message if the user has one of these tags: `bs.foo.log.bar.warn`, `bs.foo.log.bar.info`, `bs.foo.log.bar.debug`, `bs.foo.log._.warn`, `bs.foo.log._.info`, `bs.foo.log._.debug`, `bs.foo.log._._`, `bs.foo.log.bar._`, `_.log.bar.warn`, `_.log.bar.info`, `_.log.bar.debug`, `_.log._.warn`, `_.log._.info`, `_.log._.debug`, `_.log._._`, `_.log.bar._`.

![](/_imgs/modules/log/example-1.png)

*Example: Log a complex info message. We assume the log originates from the `bs.foo:baz` function:*

```mcfunction
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:baz", tag: "baz", message: [{text:"Score: ",color:"light_purple"},{score:{name:"-1",objective:"bs.const"}},{text:", "},{text:"@p: ",color:"light_purple"},{selector:"@p"},{text:", "},{text:"[hover me]",color:"light_purple",hover_event:{action:"show_text",value:"That tickles!"}}] }
```

Will display the following message if the user has one of these tags: `bs.foo.log.baz.info`, `bs.foo.log.baz.debug`, `bs.foo.log._.info`, `bs.foo.log._.debug`, `bs.foo.log.baz._`, `_.log.baz.info`, `_.log.baz.debug`, `_.log._.info`, `_.log._.debug`, `_.log.baz._`.

![](/_imgs/modules/log/example-2.png)

### Customize the Format

Bookshelf proposes to define different log message formats according to the namespace.
To add new log message formats, you have to write directly inside the storage array `bs:const log.messages`:

```{code-block} mcfunction
:force:
{
  namespaces: ["<namespace>"],
  format: {
    debug: "<SNBT compound>",
    info: "<SNBT compound>",
    warn: "<SNBT compound>",
    error: "<SNBT compound>",
  }
}
```

The `namespaces` array stores all the namespaces sharing the same log message formats.
The four formats (`error`, `warn`, `info` and `debug`) describe the log format for the respecting severity level.
The value of each must be a full SNBT text component.

Bookshelf exposes several values that can be used directly in the log messages format:

|             | storage  |        path        |                                      description                                        |
|-------------|----------|--------------------|-----------------------------------------------------------------------------------------|
{nbt}`string` | bs:in    | log.message        | The message of the log (must be a valid SNBT text component)                            |
{nbt}`string` | bs:in    | log.namespace      | The namespace of the current log message                                                |
{nbt}`string` | bs:in    | log.path           | The path of the function that logs the current message                                  |
{nbt}`string` | bs:in    | log.tag            | The tag of the log message                                                              |
{nbt}`string` | bs:in    | log.hours          | The hours of the log message timestamp                                                  |
{nbt}`string` | bs:in    | log.minutes        | The minutes of the log message timestamp                                                |
{nbt}`string` | bs:in    | log.seconds        | The seconds of the log message timestamp                                                |
{nbt}`string` | bs:in    | log.ticks          | The ticks of the log message timestamp                                                  |
{nbt}`int`    | bs:in    | log.gametime       | The gametime where the message was logged                                               |
{nbt}`string` | bs:const | log.time_hms       | A SNBT text component to display time in the in hh:mm:ss format                         |
{nbt}`string` | bs:const | log.time_hmst      | A SNBT text component to display time in the in hh:mm:ss:tt format                      |

*Example: Define custom log message formats for the namespace `bs.foo`:*

```{code-block} mcfunction
:force:
data modify storage bs:const log.messages append value { \
    namespaces: ["bs.foo"], \
    format: { \
      debug: ["", {nbt: "log.full_time", storage: "bs:const", interpret: true, color: "red"}, " [DEBUG] - ", {nbt: "log.message", storage: "bs:in", interpret: true}], \
      info: ["", {nbt: "log.full_time", storage: "bs:const", interpret: true, color: "red"}, " [INFO] - ", {nbt: "log.message", storage: "bs:in", interpret: true}], \
      warn: ["", {nbt: "log.full_time", storage: "bs:const", interpret: true, color: "red"}, " [WARN] - ", {nbt: "log.message", storage: "bs:in", interpret: true}], \
      error: ["", {nbt: "log.full_time", storage: "bs:const", interpret: true, color: "red"}, " [ERROR] - ", {nbt: "log.message", storage: "bs:in", interpret: true}] \
    } \
}
```

And to try the new format:
```mcfunction
tag @s add bs.foo.log.bar.warn
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"A warning message"' }
```

---

```{include} ../_templates/comments.md
```
