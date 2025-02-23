# Executes a function to replace the block the player is aiming at, within a maximum distance of 5 blocks.
function #bs.view:at_aimed_block { run: "function bs.example.painter:replace_block", with: { max_distance: 5 }}

# Resets the brush use score and revokes the advancement.
scoreboard players reset @s bs.example.painter.use_brush
advancement revoke @s only bs.example.painter:use_brush
