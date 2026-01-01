# Check for error condition count < 0
$scoreboard players set #c bs.ctx $(count)
$data modify storage bs:ctx _ set value $(value)
execute if score #count bs.ctx matches ..-1 run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:repeat/repeat", tag: "repeat", message: '"Count must be positive"'}
execute if score #count bs.ctx matches ..-1 run return fail

data modify storage bs:out collection.value set value []
function bs.collection:repeat/repeat_rec
