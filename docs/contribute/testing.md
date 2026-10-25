# 🧪 Testing

Tests check that your code works and keeps working. Bookshelf uses [Ward](https://github.com/mcbookshelf/ward). Ward runs tests on a real Minecraft server. You write each test as a function.

---

(contribute-running-tests)=
## Run the tests

```sh
# Test every module
uv run test

# Test only the modules you name
uv run test <module1> ...
```

The command builds the modules and runs their tests. You don't need to open the game. The first run downloads the server.

:::{list-table}
*   - `--coverage`
    - Report which lines of the modules the tests ran
*   - `--coverage-report <FORMAT[:PATH]>`
    - Write the coverage as `lcov` or `html`. The path is optional
*   - `--verbose`
    - List every test, even in a large run
*   - `--reporter <live|github>`
    - Choose how to show the results. Use `github` in GitHub Actions
*   - `--junit-xml <PATH>`
    - Write the results as JUnit XML
:::

---

## Where tests live

A test is a `.mcfunction` file in the `test` folder of the module. Name it after the feature that it tests:

```text
data/bs.xp/test/add_progress.mcfunction
data/bs.hitbox/test/get_block/collision.mcfunction
```

- Start a test with the [license header](#contribute-license-header), like any function.
- A test can call anything in its module, including private functions.

---

## Write a test

A test runs its commands in order. It fails as soon as one check fails. It passes when it reaches the end.

```mcfunction
# @dummy

function #bs.xp:add_progress.in {progress:0.1}
assert result 100 run data get entity @s XpP 1000

data modify storage bs.xp:add_progress in set value {progress:0.4}
function #bs.xp:add_progress
assert result 500 run data get entity @s XpP 1000
```

Ward adds commands that work only in tests:

:::{list-table}
*   - `assert <condition>`
    - Fail the test if the condition is false
*   - `await <condition>`
    - Wait until the condition is true. Fail if the test runs out of time
*   - `await delay <time>`
    - Wait for the given time
*   - `fail <message>`
    - Fail the test
*   - `succeed`
    - Pass the test
*   - `dummy <name> <action>`
    - Control a fake player
:::

A comment that starts with `@` at the top of the test is a directive. It configures the test:

:::{list-table}
*   - `# @dummy`
    - Spawn a fake player and run the test as this player
*   - `# @skyaccess true`
    - Remove the barrier blocks that Ward places above the test
*   - `# @environment <id>`
    - Use another test environment. The default is the generated `<module>:default` environment
:::

```{admonition} Learn more
:class: info

The Ward documentation lists every [command](https://github.com/mcbookshelf/ward/blob/HEAD/docs/commands.md), [directive](https://github.com/mcbookshelf/ward/blob/HEAD/docs/directives.md), and [dummy action](https://github.com/mcbookshelf/ward/blob/HEAD/docs/dummies.md).
```
