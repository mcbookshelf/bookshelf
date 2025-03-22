# ⌚ Time

**`#bs.time:help`**

Get information about the system time effortlessly.

```{admonition} Enable Command Blocks
:class: warning

This module uses a command block to get the system time. For the time to be displayed as intended, be sure that `enable-command-block` is set to `true` in you `server.properties` file and that the `sendCommandFeedback` gamerule is enabled.
```

##  🔧 Functions

You can find below all functions available in this module.

---

###  System Time

```{function} #bs.time:get

Get the system time corresponding to the real hours, minutes and seconds.

:Outputs:
  **Score `$time.hours bs.out`**: System time hours.

  **Score `$time.minutes bs.out`**: System time minutes.

  **Score `$time.seconds bs.out`**: System time seconds.
```

*The moment we all dread:*
```mcfunction
function #bs.time:get

tellraw @a [{"text":"It is "},{"score":{"name":"$time.hours","objective":"bs.out"}},{"text":"h, "},{"score":{"name":"$time.minutes","objective":"bs.out"}},{"text":"m and "},{"score":{"name":"$time.seconds","objective":"bs.out"}},{"text":"s. Time to wake up!"}]
```

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
