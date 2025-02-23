# 🎨 Block Painter

In this guide, we'll learn how to create a block painter system in Minecraft using the Bookshelf library. The painter will allow players to change the block material of an aimed block according to the material of a held block, while keeping the same shape. For example, if a player holds oak planks and looks at birch stairs, using the painter will transform the stairs into oak stairs while keeping their shape.

## 🎯 What We'll Build

Our painter system will:
1. Detect when a player uses a specific item (our painter tool)
2. Get the block type from the item in their main hand
3. Get the block they're looking at
4. Apply the properties of the held block type to the looked-at block

## 📦 Prerequisites

Before we start, make sure you have:
- Minecraft Java Edition 1.20.4 or later
- Bookshelf library installed in your datapack, see [Quickstart](quickstart.md)
  - More specifically, the `bs.block` and `bs.view` modules
- Basic knowledge of datapack development

This guide is written with Bookshelf 2.2.0 in mind.

## 🛠️ Step-by-Step Implementation

### 1. Prepare the datapack structure

First, we'll create a new datapack in which we'll implement our painter system.
Here the structure of the datapack:

:::{treeview}
- {dir}`folder` Bookshelf Examples
  - {dir}`mcmeta` pack.mcmeta
  - {dir}`folder` data
    - {dir}`folder` bs.example.painter
      - {dir}`folder` advancement
      - {dir}`folder` function
        - {dir}`mcfunction` \_\_load\_\_.mcfunction
        - {dir}`mcfunction` \_\_tick\_\_.mcfunction
    - {dir}`folder` minecraft/tags/function
      - {dir}`json` load.json
      - {dir}`json` tick.json
:::

The `__load__.mcfunction` and `__tick__.mcfunction` should be called respectively by the `load.json` and `tick.json` files in the `minecraft` namespace.
Finally, we'll create a new scoreboard in the `__load__.mcfunction` file:

```mcfunction
scoreboard objectives add bs.ctx dummy
```

This scoreboard will be used to do some operations as we'll see later.

### 2. Setting Up the Painter Tool

First, we need to create a way to detect when a player wants to use the painter.
For that, we'll use a the brush item.
When the player right-clicks with the brush, we'll trigger our painter system.
For that, we'll create an advancement that triggers when the player uses the brush.
Create the advancement `use_brush.json` in the `advancement` folder to detect right clicks

```json
{
  "criteria": {
    "requirement": {
      "trigger": "minecraft:using_item",
      "conditions": {
        "player": [],
        "item": {
          "items": ["minecraft:brush"],
          "predicates": {
            "minecraft:custom_data": "{\"bs.example.painter:brush\":true}"
          }
        }
      }
    }
  },
  "rewards": {
    "function": "bs.example.painter:painter/use_brush"
  }
}
```

Note that we trigger our painter system only if the brush has the custom data component `bs.example.painter:brush`.
Thanks to this, the vanilla brush will still work as expected.
The reward enables us to trigger a specific function when the brush is used.
For the moment, let's create the called function `use_brush.mcfunction` in the `function` folder and fill it with a simple `say` command.

```mcfunction
say Painter used!
```

We can now test our dummy painter by giving ourselves a brush and using it:

```mcfunction
give @s minecraft:brush[minecraft:custom_data={ "bs.example.painter:brush": true }]
```

Now… Right-click with the brush while looking at a block and you will see the message `Painter used!` in chat.
Unfortunately, if you try again, nothing will happen.
The reason is that your player now have the advancement `use_brush` and will not be triggered again.
To resolve this, we need to reset the advancement when the function is called.
Add the following line to the end of the `use_brush.mcfunction` file:

```mcfunction
advancement revoke @s only bs.example.painter:use_brush
```

Try again without forgetting to manually reset the advancement a first time, and you will see that the message is now displayed each time you use the brush.

### 3. Getting Aimed Block Information

Okay, so now we can detect a right-click with a brush, but our current function is executed at the user position.
To verify that, you can replace the `say` command with a `setblock` command.
But in our case, we want to transform the aimed block and for that, we need to get information about the block the player is looking at.
Sadly, Minecraft doesn't provide a simple way to do that, but Bookshelf does!

For that, we'll use the `bs.view` module and more specifically the [`at_aimed_block`](project:../modules/view.md#aimed-block) function.
This function allows us to execute a command directly at the aimed block position.
Replace the `say` command with the following line in the `use_brush.mcfunction` file:

```mcfunction
function #bs.view:at_aimed_block { run: "function bs.example.painter:replace_block", with: {}}
```

And create the `replace_block.mcfunction` file in the `function` folder:

```mcfunction
setblock ~ ~ ~ minecraft:slime_block
```

Now, each time we use the painter, `use_brush` will execute `replace_block` at the aimed block position to replace it with a slime block.

You may have noticed we have an empty `with` macro variable.
It is important to know that we cannot pass optional macro variables to a function.
However, this may be really useful to reduce the number of macro variables by considering default values for some of them.
Since the values of the macro variables can be a NBT component, we use the `with` variable to pass optional variables to the function.
Here we don't need to pass any optional variable, so we just leave it empty.

### 4. Painting the Aimed Block

Now we are able to modify the aimed block, let's do the painting part!
As reminder, we want to apply properties of a held block to the aimed block.
For that, we'll only consider blocks present into the offhand slot (slot -106).

to do this part, we'll use the `bs.block` module
This module proposes numerous functions to transform blocks.
It usage is most of the time done in three steps:
1. Load a block from the world or from an item in memory (_i.e._, in a storage), we named the loaded block "virtual block"
2. Apply different transformation operations to the virtual block
3. Produce from the virtual block a new block, item, particle, block display, etc.

In our case, we'll load the aimed block, apply the [`mix_type`](project:../modules/block.md#manage-type) transformation and produce a new block at the same position.
The `mix_type` function takes in input a block type and a mapping registry.
Basically, the mapping registry is the way to tell Bookshelf how to transform the virtual block according to the properties of the given block type.
By default, Bookshelf provides two mapping registries:
- `bs.colors`: Used to transform blocks based on their color
- `bs.shapes`: Used to transform blocks based on their shape
In our case, we'll use the `bs.shapes` mapping registry to transform blocks based on their shape.
For example, with a oak planks block type, and a virtual block of type birch stairs, the `mix_type` function will transform the virtual block into an oak stairs block.
Other example, with a mossy cobblestone block type, and a virtual block of type stone bricks, the `mix_type` function will transform the virtual block into a mossy stone bricks block.

So first, we'll prepare the input of the `mix_type` function, for that we need to specify the mapping registry we want to use and the held block's block type.
Here, we'll put the input in the `bs:example painter` storage.
Replace the `setblock` command in the `replace_block.mcfunction` file with the following lines:

```mcfunction
data modify storage bs:example painter set value { mapping_registry: "bs.shapes" }
execute store success score #success bs.ctx run data modify storage bs:example painter.type set from entity @s Inventory[{Slot:-106b}].id
execute if score #success bs.ctx matches 0 run return fail
```

Note that we use a score to check if the command was successful.
This is a good practice to detect if the command failed and take appropriate actions, here we return a fail if the command failed to avoid executing the next commands and having unexpected results.

Next, we need to load the aimed block.
Thanks to the `bs.view:at_block` function which call the `replace_block.mcfunction` were are developing, the current execution context is already at the aimed block position.
So we can directly load the block into the `bs:example painter` storage using the [`get_block`](project:../modules/block.md#get) function.
Add the following line to the end of the `replace_block.mcfunction` file:

```mcfunction
function #bs.block:get_block
```

We have loaded the aimed block and prepared the input of the `mix_type` function, now we can apply the transformation, without forgetting to give the prepared input to the function:

```mcfunction
execute store success score #success bs.ctx run function #bs.block:mix_type with storage bs:example painter
execute if score #success bs.ctx matches 0 run return fail
```

The `mix_type` function outputs its result into the `bs:out block` storage, and returns 0 if no transformation was found.
We use the return number to check if the transformation was not done, and return a fail if it is the case to avoid replacing the block.

Finally, we need to produce the new block at the aimed block position, for that we'll use the [`set_block`](project:../modules/block.md#set) function.
Add the following line to the end of the `replace_block.mcfunction` file:

```mcfunction
data modify storage bs:in block.set_block set from storage bs:out block
function #bs.block:set_block
```

Here, the `set_block` function takes a virtual block in input, but here, the virtual block is given through the `bs:in block` storage and not directly in the function call.
This is for performance reasons since macro variables may be expensive to compute.
As the `#bs.block:mix_type` outputs its result into the `bs:out block` storage, we need to move it to the `bs:in block` storage before calling the `set_block` function.

At this end, your function should look like this:

```mcfunction
# Prepare the input of the mix_type function
data modify storage bs:example painter set value { mapping_registry: "bs.shapes" }
execute store success score #success bs.ctx run data modify storage bs:example painter.type set from entity @s Inventory[{Slot:-106b}].id
execute if score #success bs.ctx matches 0 run return fail

# Load the aimed block
function #bs.block:get_block

# Apply the transformation
execute store success score #success bs.ctx run function #bs.block:mix_type with storage bs:example painter
execute if score #success bs.ctx matches 0 run return fail

# Produce the new block
data modify storage bs:in block.set_block set from storage bs:out block
function #bs.block:set_block

```

If you try to paint a block now, you will see that the block is transformed, perfect!
Now, try this on a sign, and you will see that the block is not transformed to get the material of the hold block.
This is because the `using_item` advancement criterion does not trigger on certain blocks like signs.
To fix that, we can complement our approach by using a scoreboard objective to track when a player uses a brush.

For that, we'll create an objective `bs.example.painter.use_brush` in the `__load__.mcfunction` file:

```mcfunction
scoreboard objectives add bs.example.painter.use_brush minecraft.used:minecraft.brush
```

The player's score in the `bs.example.painter.use_brush` objective is incremented each time the player uses a brush.
Now, we have to trigger the `use_brush` function when the score is incremented.
To do that, we'll add a new command to the `__tick__.mcfunction` file:

```mcfunction
execute as @a[scores={bs.example.painter.use_brush=1..}] run function bs.example.painter:use_brush
```

And reset the the score in the function `use_brush.mcfunction` when it's executed:

```mcfunction
scoreboard players reset @s bs.example.painter.use_brush
```

And… That's it!
You can now paint blocks with the painter tool, and as you see, this is really simple to do!

## 📚 Conclusion

You've now created a functional block painter using Bookshelf! This project demonstrates how to:
- Use Bookshelf's view module to get aimed block
- Use Bookshelf's block module for block manipulation

The painter is not just a useful tool but also a great example of how Bookshelf simplifies complex datapack development.
Feel free to experiment with the code and add your own features!
