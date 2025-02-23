# Clears the player's inventory.
clear @s

# Replaces the first hotbar slot with the color brush item.
item replace entity @s hotbar.0 with minecraft:brush[ \
  minecraft:custom_data={ "bs.example.painter:brush": true, "bs.example.painter:brush_type": "color" }, \
  minecraft:item_name='["",{"text":"PAINT BRUSH","color":"gold","bold":true,"italic":true},{"text":" - Right click to use","color":"gray"}]', \
  minecraft:lore=['{"text":"A brushstroke of imagination.","color":"dark_gray","italic":false}','""','{"text":"Imbue the aimed block with the color","color":"gray","italic":false}','{"text":"of the block held in your offhand.","color":"gray","italic":false}'], \
]

# Replaces the second hotbar slot with the magic brush item.
item replace entity @s hotbar.1 with minecraft:brush[ \
  minecraft:custom_data={ "bs.example.painter:brush": true, "bs.example.painter:brush_type": "magic" }, \
  minecraft:item_name='["",{"text":"MAGIC BRUSH","color":"light_purple","bold":true,"italic":true},{"text":" - Right click to use","color":"gray"}]', \
  minecraft:lore=['{"text":"A brushstroke of creation.","color":"dark_gray","italic":false}','""','{"text":"Imbue the aimed block with the properties","color":"gray","italic":false}','{"text":"of the block held in your offhand.","color":"gray","italic":false}'], \
]

# Replaces additional hotbar slots with various blocks to use in the offhand.
item replace entity @s hotbar.5 with minecraft:birch_planks
item replace entity @s hotbar.6 with minecraft:spruce_planks
item replace entity @s hotbar.7 with minecraft:cyan_wool
item replace entity @s hotbar.8 with minecraft:orange_wool
