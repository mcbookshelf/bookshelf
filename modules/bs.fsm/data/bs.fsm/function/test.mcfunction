execute unless entity B5-0-0-0-9 run summon marker ~ ~ ~ {Tags:["bs.entity", "bs.fsm.test"], UUID:[I;181,0,0,9]}

data modify entity B5-0-0-0-9 data set value {}
data modify storage bs:data fsm set value { fsm: {}, running_instances: {}, listened_transitions: [], ticks: [] }

# Create a traffic light FSM
function bs.fsm:new { \
  name: "traffic_light", \
  fsm: { \
    initial: "red", \
    states: [ \
      { \
        name: "red", \
        on_enter: "tellraw @a [{\"text\":\"⬤\",\"color\":\"red\"},{\"text\":\" Red light - Stop!\"}]", \
        on_tick: "particle minecraft:block{block_state:{Name:\"red_concrete\"}} ~ ~2 ~ 0.5 0.5 0.5 0 10", \
        transitions: [ \
          { \
            name: "to_green", \
            condition: { type: "delay", wait: 100 }, \
            to: "green" \
          }, \
          { \
            name: "to_off", \
            condition: "manual", \
            to: "off" \
          } \
        ] \
      }, \
      { \
        name: "green", \
        on_enter: "tellraw @a [{\"text\":\"⬤\",\"color\":\"green\"},{\"text\":\" Green light - Go!\"}]", \
        on_tick: "particle minecraft:block{block_state:{Name:\"green_concrete\"}} ~ ~2 ~ 0.5 0.5 0.5 0 10", \
        transitions: [ \
          { \
            name: "to_orange", \
            condition: { type: "delay", wait: 100 }, \
            to: "orange" \
          }, \
          { \
            name: "to_off", \
            condition: "manual", \
            to: "off" \
          } \
        ] \
      }, \
      { \
        name: "orange", \
        on_enter: "tellraw @a [{\"text\":\"⬤\",\"color\":\"gold\"},{\"text\":\" Orange light - Prepare to stop!\"}]", \
        on_tick: "particle minecraft:block{block_state:{Name:\"yellow_concrete\"}} ~ ~2 ~ 0.5 0.5 0.5 0 10", \
        on_exit: "tellraw @a [{\"text\":\" Reset cycle…\"}]", \
        transitions: [ \
          { \
            name: "to_red", \
            condition: { type: "delay", wait: 100 }, \
            to: "red" \
          }, \
          { \
            name: "to_off", \
            condition: "manual", \
            to: "off" \
          } \
        ] \
      }, \
      { \
        name: "off", \
        final: true, \
        on_enter: "tellraw @a [{\"text\":\"⬤\",\"color\":\"black\"},{\"text\":\" Off light - Be careful!\"}]", \
        on_tick: "particle minecraft:block{block_state:{Name:\"black_concrete\"}} ~ ~2 ~ 0.5 0.5 0.5 0 10", \
      } \
    ] \
  } \
}

# Start the traffic light FSM
execute as B5-0-0-0-9 run function bs.fsm:start_as { \
  fsm_name: "traffic_light", \
  instance_name: "main_traffic_light" \
}
