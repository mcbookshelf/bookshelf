scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]

data modify storage bs:data collection merge value { stack: [] }
data modify storage bs:lambda collection set value {}
