# 🖌️ Paintbrush

This example shows how to create a paintbrush in Minecraft using the Bookshelf library. The paintbrush changes a block's material to match the item in the player's hand, while preserving important properties like orientation, waterlogging, and other block states. For instance, if the player holds oak planks, birch stairs will transform into oak stairs.

---

## 🎯 What We'll Build

Our paintbrush system will:
1. Detect when a player interacts with a block using the brush
2. Determine the block type from the item in the player's hand
3. Identify the targeted block
4. Replace the targeted block's material with that of the held item

---

## 📦 Requirements

Before we start, make sure you have:
- Minecraft Java Edition 1.21.4 or later
- Bookshelf `bs.block` and `bs.view` modules, see [Quickstart](https://docs.mcbookshelf.dev/en/latest/quickstart.html) for installation
  - `@require bookshelf.module.block`
  - `@require bookshelf.module.view`
- Basic knowledge of datapack development, including functions, tags, and scoreboards
- A ready to use empty datapack

---

## 🛠️ Step-by-Step Implementation

### 1. Prepare the Datapack

First, we need a function to initialize our system when the datapack loads. Create a function named `paintbrush:load` and register it in the `minecraft:load` function tag.

---

**➔ create the `load` function**

`@function paintbrush:load`
```mcfunction
scoreboard objectives add data dummy
```

This scoreboard will store data for the paintbrush, primarily the values returned by commands.

**➔ register it in the `load` tag**

`@function_tag minecraft:load`
```json
{
  "values": [
    "paintbrush:load"
  ]
}
```

This ensures that `paintbrush:load` runs automatically when the datapack is enabled or reloaded.

---

### 2. Detect Player Interaction

First, we need to create an item that the player can use to paint a block. For this, we'll use a brush item. Then, to trigger our system when the player interacts with a block using the brush, we'll use an advancement.

---

**➔ create the `use` advancement**

`@advancement paintbrush:use`
```json
{
  "criteria": {
    "requirement": {
      "trigger": "minecraft:using_item",
      "conditions": {
        "player": [],
        "item": {
          "items": [
            "minecraft:brush"
          ],
          "predicates": {
            "minecraft:custom_data": "{\"paintbrush\":true}"
          }
        }
      }
    }
  },
  "rewards": {
    "function": "paintbrush:use"
  }
}
```

The reward enables us to trigger a specific function when the brush is used. We'll use the `paintbrush:use` function here.

> Note that this advancement triggers the function only if the brush has the custom data `{paintbrush: true}`, ensuring that vanilla brushes continue to function normally.

**➔ create the `use` function**

`@function paintbrush:use`
```mcfunction
say Paintbrush used!
```

**➔ create the `give` function**

`@function paintbrush:give`
```mcfunction
give @s minecraft:brush[ \
  minecraft:custom_data={ paintbrush: true }, \
  minecraft:item_name=["",{text:"MAGIC BRUSH",color:"light_purple",bold:true,italic:true},{text:" - Right click to use",color:"gray"}], \
  minecraft:lore=[{text:"A brushstroke of creation.",color:"dark_gray",italic:false},"",{text:"Imbue the aimed block with the properties",color:"gray",italic:false},{text:"of the block held in your offhand.",color:"gray",italic:false}], \
]
```

Next, test it by giving yourself a brush by running `function paintbrush:give`. Now… right-click, and you'll see "Paintbrush used!" in the chat. However, if you try again, nothing will happen. This is because the player now has the `painterbrush:use` advancement, which prevents it from triggering again. Since advancements only trigger once per player, we need to reset it each time the brush is used.

**➔ update the `use` function**

`@function paintbrush:use`
```mcfunction
advancement revoke @s only paintbrush:use
say Paintbrush used!
```

Try again (remember to manually reset the advancement once before testing), and you'll see that the message now appears every time you use the brush.

---

### 3. Replace the Targeted Block

We've successfully set up the detection for when a player right-clicks with the brush. However, the issue now is that our function runs at the player's position. What we actually want to do is transform the block the player is aiming at. While Minecraft doesn't provide a straightforward way to get this information, the Bookshelf library does!

---

We can use the `bs.view` module, specifically the `at_aimed_block` function, which allows us to execute commands directly at the position of the block the player is targeting.

**➔ update the `use` function**

`@function paintbrush:use`
```mcfunction
advancement revoke @s only paintbrush:use
function #bs.view:at_aimed_block { run: "function paintbrush:replace_block", with: {} }
```

**➔ create the `replace_block` function**

`@function paintbrush:replace_block`
```mcfunction
setblock ~ ~ ~ minecraft:bookshelf
```

Now, each time the player uses the paintbrush, the `paintbrush:use` function will execute `paintbrush:replace_block` at the aimed block's position, replacing it with a bookshelf block.

> You may have noticed an empty `with` macro variable. We can't pass optional macro variables to a function directly, but using `with` allows us to set default values for them. In this case, we don't need to pass any optional variables, so we leave it empty.

---

### 4. Paint the Targeted Block

Now, let’s move on to painting! We’ll use the `bs.block` module to apply the block type from the item held in the offhand (slot -106) to the targeted block. This process involves three steps:

1. Load the targeted block into storage (`bs:out block`) as a "virtual block"
2. Transform the virtual block using various operations (`mix_type` in this case)
3. Generate the final result from the virtual block, which can be a block, item, particle, block display, etc. (here, we’ll replace the block with its transformed version).

---

#### Set Up the Transformation

The `mix_type` function uses a mapping registry to determine how blocks are transformed. Bookshelf provides two built-in registries:
- `bs.colors`: This registry is used to transform blocks based on color properties. For example, if the held item is a colored block, it will attempt to apply the color transformation to the targeted block.
- `bs.shapes`: This registry is used to transform blocks based on their shape. For instance, if the held block is an oak planks, and the targeted block is a birch stairs, this registry would map the oak plank to a corresponding block shape like oak stairs. This is ideal for transforming between blocks that have a similar structural shape.

These registries allow for more specific control over how block transformations occur. In this example we'll use `bs.shapes`. To set up the transformation, we specify the `mapping_registry` and store the block `type` from the player's offhand into an arbitrary storage.

**➔ update the `replace_block` function**

`@function paintbrush:replace_block`
```mcfunction
# Prepare the input of the mix_type function
data remove storage painterbrush:input type
data modify storage painterbrush:input mapping_registry set value "bs.shapes"
execute store success score #success data run data modify storage painterbrush:input type set from entity @s equipment.offhand.id
execute if score #success data matches 0 run return fail
```

> Here, we use a score to check if the command succeeds. If it fails, we return immediately to prevent unintended behavior.

---

#### Load the Targeted Block

The `#bs.view:at_aimed_block` function ensures that execution is already at the targeted block position, so we can directly load it using `get_block`.

**➔ update the `replace_block` function**

`@function paintbrush:replace_block`
```mcfunction
# Prepare the input of the mix_type function
data remove storage painterbrush:input type
data modify storage painterbrush:input mapping_registry set value "bs.shapes"
execute store success score #success data run data modify storage painterbrush:input type set from entity @s equipment.offhand.id
execute if score #success data matches 0 run return fail

# Load the aimed block
function #bs.block:get_block
```

---

#### Apply the Transformation

Now that the block is loaded and the transformation input is ready, we can apply `mix_type`.

**➔ update the `replace_block` function**

`@function paintbrush:replace_block`
```mcfunction
# Prepare the input of the mix_type function
data remove storage painterbrush:input type
data modify storage painterbrush:input mapping_registry set value "bs.shapes"
execute store success score #success data run data modify storage painterbrush:input type set from entity @s equipment.offhand.id
execute if score #success data matches 0 run return fail

# Load the aimed block
function #bs.block:get_block

# Apply the transformation
execute store success score #success data run function #bs.block:mix_type with storage painterbrush:input
execute if score #success data matches 0 run return fail
```

> The `mix_type` function directly overwrites the virtual block in `bs:out` storage with the transformed value. If it returns 0, no transformation was found, so we return a failure.

---

#### Place the Transformed Block

Finally, we apply the transformed block to the world using `set_block`.

**➔ update the `replace_block` function**

`@function paintbrush:replace_block`
```mcfunction
# Prepare the input of the mix_type function
data remove storage painterbrush:input type
data modify storage painterbrush:input mapping_registry set value "bs.shapes"
execute store success score #success data run data modify storage painterbrush:input type set from entity @s equipment.offhand.id
execute if score #success data matches 0 run return fail

# Load the aimed block
function #bs.block:get_block

# Apply the transformation
execute store success score #success data run function #bs.block:mix_type with storage painterbrush:input
execute if score #success data matches 0 run return fail

# Produce the new block
data modify storage bs:in block.set_block set from storage bs:out block
function #bs.block:set_block
```

This completes the transformation process. If you try to paint a block now, you will see that the block is transformed, perfect!

---

### 5. Going Further

If you try this on a sign, you will see that the block is not transformed to match the material of the held block. This is because the `using_item` advancement criterion does not trigger on certain blocks, like signs. To fix this, we can complement our approach by using a scoreboard objective to track when a player uses a brush. We need to trigger the `use` function when the score increments. To do this, we'll add a new `tick` function that runs on a loop and reset the score in the `paintbrush:use` function.

---

**➔ update the `load` function**

`@function paintbrush:load`
```mcfunction
scoreboard objectives add data dummy
scoreboard objectives add use_brush minecraft.used:minecraft.brush
schedule function paintbrush:tick 1t
```

**➔ create the `tick` function**

`@function paintbrush:tick`
```mcfunction
execute as @a[scores={use_brush=1..}] run function paintbrush:use
schedule function paintbrush:tick 1t
```

**➔ update the `use` function**

`@function paintbrush:use`
```mcfunction
scoreboard players reset @s use_brush
advancement revoke @s only paintbrush:use
function #bs.view:at_aimed_block { run: "function paintbrush:replace_block", with: {} }
```

And… That's it! You can now paint blocks with the painter tool, and as you can see, this is really simple to do!

---

## ✔️ Conclusion

Congratulations! You’ve successfully created a functional paintbrush using Bookshelf! This project demonstrates how to:

- Use Bookshelf's view module to get the aimed block
- Use Bookshelf's block module for block manipulation

The paintbrush is not only a useful tool but also a great example of how Bookshelf simplifies complex datapack development. Feel free to experiment with the code and add your own features to make it even more powerful!
