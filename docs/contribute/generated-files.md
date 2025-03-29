# ⚙️ Generated Files

When building modules with **[Beet](https://github.com/mcbeet/beet)**, several files are automatically generated to simplify development and improve consistency. This page outlines what happens behind the scenes.

---

## 📦 Module Management

Modules are bundled with their dependencies:
- If Module `A` depends on Module `B`, both are included in the build process.

A special loader module, `bs.load`, along with `load` (LanternLoad), is created to:
- Resolve version conflicts and manage dependencies between modules.
- Ensure load functions are called in the correct order, maintaining reliable datapack behaviors.

During the build process, the `pack.mcmeta` file is automatically updated to ensure compatibility:
- `pack_format` is set to the latest supported Minecraft version.
- `supported_formats` specifies a compatible version range.

---

## 🗂️ Resource-Based Plugins

Beyond module management, Bookshelf automatically generates data across multiple resource types.

### 📄 Function Related

Bookshelf enhances the contributor and user experience by:

- Automatically adding functions from the module's `import` folder to the `__load__` function.
- Generating a `__help__` function and its `help` tag linking to the module's documentation.

### 🧪 Test Related

Bookshelf uses PackTest to run tests for its modules. To ensure smooth execution, it:

- Automatically includes `@batch <module>` instructions in test functions.
- Generates a `__setup__` test function to isolate and load only the module being tested.

### 🏷️ Tag Related

To ensure proper loading and versioning, Bookshelf requires non-overridable tags. It:

- Updates all tags with the `replace` key set to `true`.

---

## 🧩 Module-Specific Plugins

In addition to these shared plugins, each module can include its own plugins that hook into the build pipeline. Some modules may have plugins that are responsible for generating data specific to themselves, providing even greater flexibility during the build process.
