# 🕵️ Debug

Learn about Bookshelf's debugging tools.

---

## 📦 Modules

Bookshelf includes a variety of modules designed to enhance your development experience.

---

### ⬥ 📄 Logging

Centralizes and streamlines log management, making it easier to monitor and troubleshoot your project. For more details, refer to the [log module documentation](project:../modules/log.md).

### ⬥ 🔬 Var Dumping

Provides an easy way to display scores or storage values at any given time, helping with debugging and tracking. For more details, refer to the [dump module documentation](project:../modules/dump.md).

---

## 🧪 Unit Tests

Tests are an integral part of any software development process. They help ensure the correctness of your code and can save you from potential bugs in the future. In this project, we use a Minecraft fabric mod made by Misode called [PackTest](https://github.com/misode/packtest).

---

### ✍️ Writing Tests

Each test is a `.mcfunction` file inside the `test` folder.
When writing tests, make sure to clearly define what you are testing and what the expected outcome is. It's also a good idea to include edge cases to ensure your code can handle all possible inputs.

### ⚙️ Running Tests

To run the tests, you have two options:

1. **Headless Mode**: We provide a simple command `pdm run modules test` that allows you to run the tests headlessly, without having to open the game. This is a more convenient option for continuous integration environments.

2. **In-Game**: Download and install the Minecraft fabric mod. Once that's done, you can run the tests using the test command in Minecraft.

### 🛠️ PackTest Commands

PackTest offers a variety of commands to control test flow, validate conditions, and interact with Minecraft's environment:

**Test Flow Commands**:
- `fail [<text>]`: Immediately fails the current test and logs an optional message.
- `succeed`: Immediately passes the current test.
- `assert <condition>`: Fails the test if the condition is false.
- `assert not <condition>`: Fails the test if the condition is true.
- `await <condition>`: Continuously checks a condition until it succeeds or times out.
- `await not <condition>`: Waits until the condition becomes false.
- `await delay <time>`: Pauses the test for a specified duration.

**Condition Types**:
- `block <pos> <block>`: Checks if a block at the specified position matches the given block.
- `data <path>`: Verifies NBT data using standard Minecraft data syntax.
- `entity <selector>`: Validates if entities match a selector (works beyond test boundaries).
- `predicate <predicate>`: Executes a predicate in the data pack.
- `score <target>`: Compares scores using Minecraft's score-based conditions.
- `chat <pattern> [<receivers>]`: Matches chat messages against a regex pattern.

### 🧍 PackTest Dummies

PackTest allows you to spawn and control "dummies," simulated players for testing:

- `dummy <name> spawn`: Spawns a new dummy.
- `dummy <name> respawn`: Respawns a killed dummy.
- `dummy <name> jump`: Makes the dummy jump.
- `dummy <name> sneak [true|false]`: Toggles sneaking.
- `dummy <name> sprint [true|false]`: Toggles sprinting.
- `dummy <name> use item`: Simulates the dummy using an item.
- `dummy <name> mine <pos>`: Commands the dummy to mine a block.

### 📋 PackTest Directives

You can customize tests using directives (special comments at the beginning of the test):

- `@template`: Specifies the resource location of a structure template to use for the test.
- `@timeout`: Sets the maximum time (in ticks) before the test fails (default: 100).
- `@dummy`: Spawns a dummy for testing (e.g., `@dummy ~0.5 ~ ~0.5`).
- `@optional`: Marks the test as allowed to fail (useful for non-critical cases).

---

For more information on how to write and run tests, you can refer to Misode's [PackTest repository](https://github.com/misode/packtest).
