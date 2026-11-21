# 🛡️ Maintainer guide

This page is for maintainers. It explains how to write commit messages and how to version, release, and publish modules and bundles.

---

## Commit messages

Contributors don't need to follow these rules: maintainers squash each pull request into one commit when they merge it.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org). Start each message with an emoji that shows the type of change:

```html
<type>[(<scope>)]: <message>
```

:::{list-table}
*   - `✨ feat`
    - Adds a feature
*   - `🐛 fix`
    - Fixes a bug
*   - `⚡️ perf`
    - Makes the code faster
*   - `♻️ refactor`
    - Changes the code but not its behavior
*   - `🎨 style`
    - Changes the code style but not its behavior, for example formatting or spacing
*   - `📝 docs`
    - Changes the documentation
*   - `🧪 test`
    - Adds or changes tests
*   - `🔨 build`
    - Changes the scripts that build the project
*   - `⚙️ ci`
    - Changes the continuous integration workflows or scripts
*   - `🛠️ chore`
    - Routine work, such as version bumps, metadata updates, or asset changes
:::

Add a **scope** to show which part of the project changes. For a breaking change, add a `!` after the type or the scope:

```
📝 docs(bs.block): update get_block output
✨ feat(bs.block)!: add a new macro argument to the replace_type function
```

---

## Versioning

Each module and each bundle has its own version. You find it in the `module.bs` or `bundle.bs` file.

- A module is **released** when its version reaches `1.0.0`. Before that, only nightly builds include it.
- The version of a bundle follows its modules. A module that leaves the bundle is a major change. A module that joins it is a minor change. Otherwise, the bundle takes the highest change of its modules.
- The version of a release is the version of the bundle that contains every module. The release tag adds the supported Minecraft version: `v5.0.0+26.3`.

(contribute-version-bumps)=
### Version bumps

Modules follow [semantic versioning](https://semver.org). The `Unreleased` section of the [changelog](project:changelog.md) sets the next version of the module:

:::{list-table}
*   - **Major**
    - At least one line has a `⚠️`
*   - **Minor**
    - At least one line has a `✨`
*   - **Patch**
    - Any other line
:::

The release process then renames the section to the new version and adds an empty `Unreleased` section.

When a dependency of the module gets a new version, the module gets one too, of the same level. If the module has no change of its own, the release process adds a `🛠️ Bumped as ...` line.

---

## Release flow

1. **Prepare**: run the `release-pr.yml` workflow. It sets the new versions and renames the `Unreleased` sections of the changelogs. Then it opens a pull request from a `release/<tag>` branch, with the release notes.
2. **Check**: the pull request checks the versions. It also checks that `master` didn't change in the meantime. If it did, run the workflow again.
3. **Merge**: merge the pull request. This creates the GitHub release with the packs. It moves the `v<version>` tag and the `latest` branch. Then it publishes the packs.

A push to `master` that isn't a release replaces the `nightly` pre-release. A nightly build contains every module. This includes the modules under `1.0.0` and the experimental features.

You can run the same steps on your computer:

:::{list-table}
*   - `uv run bump`
    - Set the versions that the changes since the last release require
*   - `uv run bump --check`
    - List the versions that are wrong. Change nothing
*   - `uv run notes`
    - Write the release notes from the changelogs
*   - `uv run release`
    - Build the packs in the `release` folder
*   - `uv run publish`
    - Send the packs of the `release` folder to Modrinth and Smithed. The command reads the `MODRINTH_TOKEN` and `SMITHED_TOKEN` environment variables
:::

---

## Workflows

:::{list-table}
*   - `review.yml`
    - Runs `check` and `test` on every pull request and on `master`
*   - `release-pr.yml`
    - Opens the release pull request. A maintainer starts it
*   - `release-check.yml`
    - Checks a release pull request
*   - `release.yml`
    - Runs on each push to `master`. Creates the release if its tag has no release yet. Otherwise, replaces the nightly build
*   - `publish-packs.yml`
    - Publishes a release to the platforms. The release starts it. A maintainer can also start it for a given tag
*   - `publish-pypi.yml`
    - Publishes the `mcbookshelf` Python package when its version changes
:::
