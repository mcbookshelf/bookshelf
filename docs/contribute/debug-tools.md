# 🕵️ Debug Tools

Debugging is a fundamental aspect of software development. Bookshelf provides tools to help identify and resolve issues effectively.

---

## 🧪 Unit Tests

Tests are essential for ensuring code correctness and preventing future bugs. This project uses Misode's Minecraft Fabric mod, [PackTest](https://github.com/misode/packtest), for testing.

### ⚙️ Running Tests

To run the tests, you have two options:

1. **Headless Mode**: We provide a simple command `uv run modules test` that allows you to run the tests headlessly, without having to open the game
2. **In-Game**: Download and install the Minecraft Fabric mod. Once that's done, you can run the tests using the test command in Minecraft

```{admonition} Java Required
:class: warning
Ensure that Java is installed on your system, as it is required for the command to work.
```

### ✍️ Writing Tests

Each test is a `.mcfunction` file inside the `test` folder.
When writing tests, make sure to clearly define what you are testing and what the expected outcome is. It's also a good idea to include edge cases to ensure your code can handle all possible inputs.

### 🛠️ Custom Commands

PackTest offers a variety of commands to control test flow, validate conditions, and interact with Minecraft's environment:

**Test Flow Commands**:
- `fail [<text>]`: Immediately fails the current test and logs an optional message
- `succeed`: Immediately passes the current test
- `assert <condition>`: Fails the test if the condition is false
- `assert not <condition>`: Fails the test if the condition is true
- `await <condition>`: Continuously checks a condition until it succeeds or times out
- `await not <condition>`: Waits until the condition becomes false
- `await delay <time>`: Pauses the test for a specified duration

**Condition Types**:
- `block <pos> <block>`: Checks if a block at the specified position matches the given block
- `data <path>`: Verifies NBT data using standard Minecraft data syntax
- `entity <selector>`: Validates if entities match a selector (works beyond test boundaries)
- `predicate <predicate>`: Executes a predicate in the data pack
- `score <target>`: Compares scores using Minecraft's score-based conditions
- `chat <pattern> [<receivers>]`: Matches chat messages against a regex pattern

### 🧍 Player Dummies

PackTest allows you to spawn and control "dummies," simulated players for testing:

- `dummy <name> spawn`: Spawns a new dummy
- `dummy <name> respawn`: Respawns the dummy after it has been killed
- `dummy <name> leave`: Makes the dummy leave the server
- `dummy <name> jump`: Makes the dummy jump
- `dummy <name> sneak [true|false]`: Makes the dummy hold shift or un-shift (not the same as currently crouching)
- `dummy <name> sprint [true|false]`: Makes the dummy sprint or un-sprint
- `dummy <name> drop [all]`: Makes the dummy drop the current mainhand, either one item or the entire stack
- `dummy <name> swap`: Makes the dummy swap its mainhand and offhand
- `dummy <name> selectslot`: Makes the dummy select a different hotbar slot
- `dummy <name> use item`: Makes the dummy use its hand item, either mainhand or offhand
- `dummy <name> use block <pos> [<direction>]`: Makes the dummy use its hand item on a block position
- `dummy <name> use entity <entity>`: Makes the dummy use its hand item on an entity
- `dummy <name> attack <entity>`: Makes the dummy attack an entity with its mainhand
- `dummy <name> mine <pos>`: Makes the dummy mine a block

### 📋 Test Directives

You can customize tests using directives (special comments at the beginning of the test):

- `@template`: The resource location of a structure template to use for the test, defaults to `minecraft:empty`, which is an empty 1×1×1 structure
- `@timeout`: An integer specifying the timeout, defaults to `100`
- `@optional`: Whether this test is allowed to fail, defaults to `false`, if there is no value after the directive it is considered as `true`
- `@skyaccess`: Whether this test needs sky access, defaults to `false`, which will place barrier blocks above the test
- `@dummy`: Whether to spawn a dummy at the start of the test and set `@s` to this dummy, taking a position which defaults to `~0.5 ~ ~0.5`

```{admonition} Learn more...
:class: info

If you need more information than this page provides, visit Misode's [repository](https://github.com/misode/packtest) for detailed guidance on writing tests.
```

---

## 📦 Modules

Bookshelf includes a variety of modules designed to enhance your development experience.

### 📄 Logging

Centralizes and streamlines log management, making it easier to monitor and troubleshoot your project. For more details, refer to the [log module documentation](project:../modules/log.md).

### 🔬 Var Dumping

Provides an easy way to display scores or storage values at any given time, helping with debugging and tracking. For more details, refer to the [dump module documentation](project:../modules/dump.md).
