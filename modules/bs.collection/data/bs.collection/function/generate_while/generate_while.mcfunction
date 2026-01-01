$data modify storage bs:data collection.stack prepend value { result: [], run: "$(run)", predicate: "$(predicate)", i: 0 }
function bs.collection:generate_while/generate_while_rec
data modify storage bs:out collection.value set from storage bs:data collection.stack[0].result
data remove storage bs:data collection.stack[0]
