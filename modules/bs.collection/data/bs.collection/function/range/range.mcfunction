$scoreboard players set #m bs.ctx $(min)
$scoreboard players set #n bs.ctx $(max)
$scoreboard players set #s bs.ctx $(step)

# Check for error condition min >= max
execute if score #m bs.ctx >= #n bs.ctx run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:range/range", tag: "range", message: '"Min must be strictly lower than max"'}
execute if score #m bs.ctx >= #n bs.ctx run return fail

data modify storage bs:out collection.value set value []
function bs.collection:range/range_rec
