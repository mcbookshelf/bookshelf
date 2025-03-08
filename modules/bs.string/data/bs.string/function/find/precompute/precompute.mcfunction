
data modify storage bs:ctx _.ltr set string storage bs:ctx _.needle 0 1
data modify storage bs:ctx _.needle set string storage bs:ctx _.needle 1
function bs.string:find/precompute/precompute_loop with storage bs:ctx _
