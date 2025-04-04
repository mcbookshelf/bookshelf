# 🧵 Lifestring

This example demonstrates how to create a linked health system in Minecraft using the Bookshelf library's health module. Players with the same "link ID" will share health, meaning damage taken by one player will affect all players with the same ID.

---

## 🎯 What We'll Build

Our lifestring system will:
1. Detect changes in a player's health.
2. Identify all players with the same link ID.
3. Aggregate health changes across linked players.
4. Update the shared health of all linked players.

---

## 📦 Requirements

Before we start, make sure you have:
- Minecraft Java Edition 1.21.5 or later
- Bookshelf `bs.health` module, see [Quickstart](https://docs.mcbookshelf.dev/en/latest/quickstart.html) for installation
  - `@require bookshelf.module.health`
- Basic knowledge of datapack development, including functions, tags, and scoreboards
- A ready-to-use empty datapack

---

## 🛠️ Step-by-Step Implementation

### 1. Prepare the Datapack

First, we need a function to initialize our system when the datapack loads. Create a function named `lifestring:load` and register it in the `minecraft:load` function tag.

---

**➔ create the `load` function**

`@function lifestring:load`
```mcfunction
scoreboard objectives add lifestring.link dummy
scoreboard objectives add lifestring.health dummy
```

Here, we create the following scoreboard objectives:

- `lifestring.link`: Stores the link ID for each player. Players with the same ID share health.
- `lifestring.health`: Stores the health of each player. This score is used to detect health changes.

**➔ register it in the `load` tag**

`@function_tag minecraft:load`
```json
{
  "values": [
    "lifestring:load"
  ]
}
```

This ensures that `lifestring:load` runs automatically when the datapack is enabled or reloaded.

---

### 2. Detect Health Changes

We need a function that runs periodically to detect changes in player health. First, we call the `lifestring:check` function on each player who has a `lifestring.link` score. This function calculates the difference between the current health and the health from the previous tick. If the difference is not zero, it then calls the `lifestring:change` function.

---

**➔ update the `load` function**

`@function lifestring:load`
```mcfunction
scoreboard objectives add lifestring.link dummy
scoreboard objectives add lifestring.health dummy
schedule function lifestring:tick 1t
```

**➔ create the `tick` function**

`@function lifestring:tick`
```mcfunction
execute as @a[scores={lifestring.link=-2147483648..}] run function lifestring:check
schedule function lifestring:tick 1t
```

**➔ create the `check` function**

`@function lifestring:check`
```mcfunction
execute store result score #this lifestring.health run function #bs.health:get_health {scale:1}


scoreboard players operation @s lifestring.change -= @s lifestring.health
execute unless score @s lifestring.change matches 0 run function lifestring:change
scoreboard players operation @s lifestring.change = @s lifestring.health
```

**➔ create the `change` function**

`@function lifestring:change`
```mcfunction
say Health Changed!
```

Now, each time a player's health changes, the `lifestring:change` function is triggered, and a message will appear in the chat.

---

### 3. Find Linked Players

Before modifying a player's health, we need to identify which players are linked to the one whose health changed. We'll use a predicate score check to find them.

---

**➔ create the `is_linked` predicate**

`@predicate lifestring:is_linked`
```json
{
  "condition": "minecraft:entity_scores",
  "entity": "this",
  "scores": {
    "lifestring.link": {
      "min": {
        "type": "minecraft:score",
        "target": {
          "type": "minecraft:fixed",
          "name": "#this"
        },
        "score": "lifestring.link"
      },
      "max": {
        "type": "minecraft:score",
        "target": {
          "type": "minecraft:fixed",
          "name": "#this"
        },
        "score": "lifestring.link"
      }
    }
  }
}
```

**➔ update the `change` function**

`@function lifestring:change`
```mcfunction
scoreboard players operation #this lifestring.link = @s lifestring.link
execute as @a[predicate=lifestring:is_linked] run say Health Changed!
```



store result score #this get_health

compare health with #this




execute as @a[predicate=lifestring:is_linked] run scoreboard players operation @s lifestring.change -= @s lifestring.health


execute as @a[predicate=lifestring:is_linked] run scoreboard players operation @s lifestring.change = #health


# last part make it concurent proof (GOING FURTHER)


{
  "condition": "minecraft:inverted",
  "term": {
    "condition": "minecraft:entity_scores",
    "entity": "this",
    "scores": {
      "lifestring.health": {
        "min": {
          "type": "minecraft:score",
          "target": "this",
          "score": "lifestring.change"
        },
        "max": {
          "type": "minecraft:score",
          "target": "this",
          "score": "lifestring.change"
        }
      }
    }
  }
},
