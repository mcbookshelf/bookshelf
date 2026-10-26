# 🧵 Lifestring

This example showcases a **lifestring** system, built using the `bs.health` module of Bookshelf. The system links multiple players' health, so any health change made to one player is automatically applied to all others.

By default, Minecraft lacks a reliable way to heal a player by a specific amount, and workarounds can lead to timing issues. Bookshelf solves this by ensuring health updates are consistent, allowing you to retrieve the current health at any point in the tick, even with pending changes, without worrying about tick safety.

---

## 🎯 What We'll Build

Our lifestring system will:
1. Detect when a player's health changes
2. Find all other players who are linked to that player
3. Propagate the health change across all linked players

---

## 📦 Requirements

Before we begin, make sure you have:

- Minecraft Java Edition
- A basic understanding of Minecraft datapacks, including functions, tags, and scoreboards
- The Bookshelf `bs.health` module installed (see [Quickstart](https://docs.mcbookshelf.dev/en/latest/quickstart.html) for instructions)
  - `@require bookshelf.module.health`

---

## 🛠️ Step-by-Step Guide

### 1. Prepare the Datapack

First, we need a function that runs when your datapack is loaded. We'll name it `lifestring:load` and register it in the `minecraft:load` tag. This function will set up the necessary objectives.

---

**➔ create the `load` function**

`@function lifestring:load`
```mcfunction
scoreboard objectives add lifestring.link dummy
scoreboard objectives add lifestring.health dummy
```

- *`lifestring.link`*: Stores the link ID for each player. Players with the same ID will share health.
- *`lifestring.health`*: Stores each player's health from the previous tick, so we can detect changes.

**➔ register it in the `load` tag**

`@function_tag minecraft:load`
```json
{
  "values": [
    "lifestring:load"
  ]
}
```

Adding `lifestring:load` to this tag ensures it runs automatically whenever the datapack is enabled or reloaded.

---

### 2. Link Players Together


To make two players share health, they need the same *`lifestring.link`* score. We'll create a function called `lifestring:create_link_ata`. The "ata" part stands for "as to at", a Bookshelf convention for functions that run in the context of one entity (*`as`*) while targeting another (*`at`*). This makes it easy to link one player to another with a single command:

```mcfunction
execute as <source_players> at <target_player> run function lifestring:create_link_ata
```

**➔ create the `create_link_ata` function**

`@function lifestring:create_link_ata`
```mcfunction
execute as @p \
  unless score @s lifestring.link matches 1.. \
  store result score @s lifestring.link \
  run scoreboard players add #counter lifestring.link 1

scoreboard players operation @s lifestring.link = @p lifestring.link
```

> This function first check if the target player (*`@p`*) already has a link ID. If not, it gives them a new one by incrementing a global *`#counter`* score. Then, it copies that link ID from the target player (*`@p`*) to the source player (*`@s`*).

---

### 3. Detect Health Changes

We need a function that constantly checks if a player's health has changed. We'll create a function called `lifestring:tick` that schedules itself every tick, and a function `lifestring:check` that runs for each player.

The `lifestring:check` function will compare the player's current health to the health stored from the previous tick (*`@s lifestring.health`*). If there's a difference, it will run `lifestring:change`.

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
execute as @a[scores={lifestring.link=1..}] run function lifestring:check
schedule function lifestring:tick 1t
```

**➔ create the `check` function**

`@function lifestring:check`
```mcfunction
execute store result score #this lifestring.health run function #bs.health:get_health {scale:1000}
scoreboard players operation #this lifestring.health -= @s lifestring.health
execute unless score #this lifestring.health matches 0 if score @s lifestring.health matches 0.. run function lifestring:change
scoreboard players operation @s lifestring.health += #this lifestring.health
```

> We get the current health (with a scaling of 1000, which we'll use for health in this system), then subtract the previous health to obtain the difference in *`#this`*. If the score is not 0 then the health changed and we run the change function. The second if check is here to ensure the player has a *`lifestring.health`* score. Then we add this change to the player's health score.

**➔ create the `change` function**

`@function lifestring:change`
```mcfunction
say Health Changed!
```

Now, whenever a linked player's health changes, the `lifestring:change` function is triggered, and you'll see a message in chat from that player.

---

### 4. Find Linked Players

Now that we know when a player's health changes, we need to find all other players who have the same *`lifestring.link`* score. We can do this using a predicate.

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

> This predicate checks if the *`lifestring.link`* score of the entity being evaluated (`"this"`) is equal to the *`lifestring.link`* score stored in a temporary score named *`#this`*.

**➔ update the `change` function**

`@function lifestring:change`
```mcfunction
scoreboard players operation #this lifestring.link = @s lifestring.link
execute as @a[predicate=lifestring:is_linked] run say Health Changed!
```

Now, when a player's health changes, all linked players will say "Health Changed!". However, we only want to update the health of the other linked players, not the one whose health changed. To do this, we can temporarily swap the *`#this`* score with the link ID of the player whose health changed.

**➔ update the `change` function**

`@function lifestring:change`
```mcfunction
scoreboard players operation #this lifestring.link >< @s lifestring.link
execute as @a[predicate=lifestring:is_linked] run say Health Changed!
scoreboard players operation #this lifestring.link >< @s lifestring.link
```

> The *`><`* operator swaps the scores. So, we first swap the *`#this`* score with the player's link ID, then we find all linked players (excluding the original player because their link ID is now in *`#this`*), make them say the message, and then swap the scores back to normal.

---

### 5. Update Players Health

Now we'll apply the health change to all the linked players. We'll do this by using the health difference stored in *`#this`* and applying it using Bookshelf's `#bs.health:add_health` function in a new `lifestring:update` function.

---

**➔ update the `change` function**

`@function lifestring:change`
```mcfunction
execute store result storage lifestring:update points double 0.001 run scoreboard players get #this lifestring.health

scoreboard players operation #this lifestring.link >< @s lifestring.link
execute as @a[predicate=lifestring:is_linked] run function lifestring:update
scoreboard players operation #this lifestring.link >< @s lifestring.link
```

**➔ create the `update` function**

`@function lifestring:update`
```mcfunction
function #bs.health:add_health with storage lifestring:update
scoreboard players operation @s lifestring.health += #this lifestring.health
```

However, there’s a potential issue with this approach. The `#bs.health:add_health` function cannot heal more than the player's maximum health. Since we're not limiting the *`lifestring.health`* score, we might run into trouble if it exceeds the player's max health. To ensure this doesn’t happen, we need to define a maximum health value for the score.

**➔ update the `update` function**

`@function lifestring:update`
```mcfunction
function #bs.health:add_health with storage lifestring:update
scoreboard players operation @s lifestring.health += #this lifestring.health
execute store result score #max lifestring.health run attribute @s minecraft:max_health get 1000
scoreboard players operation @s lifestring.health < #max lifestring.health
```

> The *`<`* operator sets the score to the minimum value, ensuring *`@s lifestring.health`* does not exceed *`#max lifestring.health`*.

---

## ✔️ Conclusion

The system is a great example of how Bookshelf simplifies tasks that might otherwise seem complex. It now makes linked players share the damage and healing they receive. But there are many ways you could make this system even better! Here are some ideas to think about:

1. **Different Starting Health:** What if linked players have different amounts of health to begin with? Should they all end up with the same health percentage, or the same exact health points?
2. **Maximum Health:** Should linked players add up their maximum health together? If one player's max health changes (for example, from an effect or item), how should that affect the others?
3. **Player Login:** What happens when a linked player leaves the game and comes back? Should their health be saved and synced with the group?

Try experimenting with these ideas to make the lifestring system work the way you want it to!
