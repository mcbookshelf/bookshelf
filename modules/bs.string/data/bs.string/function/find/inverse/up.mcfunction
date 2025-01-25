data modify storage bs:out string.find insert 0 from storage bs:ctx x

scoreboard players remove #c bs.ctx 1
execute if score #c bs.ctx = #bs.string.occurrence bs.data run return 0

function bs.string:find/inverse/skip with storage bs:ctx
