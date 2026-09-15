
data modify storage bs:ctx x set compute default float {type:"sqrt",input:{type:"storage",storage:"bs:ctx",path:"x"}}
data modify storage bs:ctx y set compute default integer {type:"add",inputs:[1,{type:"storage",storage:"bs:ctx",path:"y"}]}

execute unless predicate {type:"float_value_check",value:{type:"storage","storage":"bs:ctx",path:"x"},test:{min:1,max:10}} run function bs.math:log/loop_exp
