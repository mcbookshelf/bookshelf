# 🚀 Quickstart

This page gives a quick overview of how to get started with the Bookshelf library, and how to use it.

---

## 📥 Installation

:::::{tab-set}
::::{tab-item} 🔌 from manager

The Bookshelf Manager is still in its development phase, and there is no straightforward installation process at the moment. If you're not familiar with datapacks, feel free to join our Discord, we'll be delighted to assist you with the installation and usage of the library!


```{admonition} 🤝 Help us improve the installation process
:class: info

We are actively searching for web developers to create the new version of the Bookshelf Manager, a website that helps users download modules and their respective dependencies. We've already finalized the mockup for the website, you can [check it here](https://www.figma.com/file/kVAmQnmP5pWWzun0Iq2kBa/Bookshelf-Manager-V2.0-prod?type=design&node-id=0-1). If you are interested in helping us, please contact us on Discord!
```

::::
::::{tab-item} 🏷️ from release

Bookshelf releases are available on both [Github](https://github.com/mcbookshelf/Bookshelf/releases) and [Modrinth](https://modrinth.com/datapack/bookshelf-library). In each release, you will find zipped datapacks. You have multiple options for installation:

📚 **Whole Datapacks:** You can download entire datapacks which includes all modules and dependencies. This is a good option if you want to explore everything Bookshelf has to offer.

🧩 **Module by Module (only on Github):** Alternatively, you can download individual modules as datapacks. Each module zip file contains all the dependencies needed for that module to work. This is a great option if you only need specific functionalities and want to keep your installation lightweight.

After downloading, move the zip file to the datapacks directory of your Minecraft world.

Please note that while the datapacks from releases are stable, they might not include the very latest features or fixes that are available in the source code. If you want the most up-to-date version of Bookshelf, consider installing from source.

If you like the project, don't hesitate to star it on Github and/or follow it on Modrinth 😉.

::::
::::{tab-item} 🗃️ from source

If you know how datapacks work, and want to handle the installation process on your own 💪😎, first familiarize yourself with the structure of the project below. Then rendez-vous on [github](https://github.com/mcbookshelf/Bookshelf) to download the repository, and extract only what you need!

Once Bookshelf is installed on your map with specific modules (rather than the entire library), the initial step is to ensure that each module can be properly loaded with all its dependencies. Verify this by calling the `#bs.<module>:load` function for each module or check your game console for any errors.

Upon exploring the main datapack, you may notice files within the minecraft namespace. These files facilitate the autoloading of modules and the ticking of specific functions. While they are not strictly needed for Bookshelf to work, without them, you have the responsibility to manually call tick functions or reload modules.


### 🏗️ Structural Overview

The Github repository includes a demo map (still a work in progress) and four datapacks:

**📁 datapacks / Bookshelf**

This is the main datapack of the library, containing all the useful tools for your project. It's the only one to keep in the end. The datapack is divided into modules, so install only the ones you need.

**📁 datapacks / Bookshelf Dev**

This datapack includes utilities for developers, such as logs and more. Its purpose is to provide essential tools to assist you during the development phase of your project.

**📁 datapacks / Bookshelf Examples (WIP)**

This datapack contains easily-readable examples showcasing systems that can be created with Bookshelf. Its main purpose is to be read. Install it only if you wish to gain familiarity with the library by examining practical examples.

**📁 datapacks / Bookshelf World (WIP)**

This datapack contains code utilized by the world itself. It is not intended for direct use.

::::
:::::

---

## 👶 First Steps

:::{important}

Bookshelf relies on persistent entities to enhance performances. Therefore, it's important not to kill all entities. Instead, you can use the command `kill @e[tag=!bs.persistent]`. [Learn more here](contribute/shared-resources.md#entities)
:::

### 📖 Good Practices

Bookshelf is designed to minimize unintended side effects. However, complications can arise when multiple datapacks utilize the same one. To prevent potential issues, it’s always recommended to set inputs prior to executing a function. This holds true even though Bookshelf adheres to a strict policy of preserving inputs. By following this practice, you can ensure smoother operation and prevent unexpected behaviors.

:::{note}
This section is in progress. If you have some ideas about how to improve the first steps with Bookshelf, please share it on our [Discord server](https://discord.gg/MkXytNjmBt).
:::

---


<!--

Now that Bookshelf is installed on your map (or once you are on the sandbox map), let's start to make some basic stuff to understand how it work!

First, let's test if Bookshelf is correctly installed. To do so, enter the following command in your chat:

```
/function bs:hello
```

If the Gunivers-Lib is well installed, you should see "Hello World!" in the chat. If it's not the case, verify that the cheat are enabled in your world (or command-blocks are enabled in the `server.properties` file if you are on a server).

Great! Now, let's play with funny things. Place a command-block in repreat mode and powered.

<div align="center">

![](https://gunivers.net/wp-content/uploads/2022/06/Command-block-repeat-1.png)

</div>

In this command block, you can enter the command of one of the following example system:

- **LGdir** : this system allow you to shoot lasers. To shoot, take a `carrot_on_a_stick` and right-click on it!
    ```
    function bs.example:lgdir
    ```
- **Drop to place** : this system allow you to place minecraft blocks by dropping the items instead of right clicking on it. Useless so essential!
    ```
    function bs.example:drop_to_place
    ```
- **Walk Trail** : this system create a trail where the players are walking. This trail is made of items corresponding to the block they are walking on.
    ```
    function bs.example:walk_trail
    ```


:::{note}
This section is in progress. If you have some ideas about how to improves the first steps with the Glibs, please share it on our [Discord server](https://discord.gg/MkXytNjmBt).
:::

---
-->

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
