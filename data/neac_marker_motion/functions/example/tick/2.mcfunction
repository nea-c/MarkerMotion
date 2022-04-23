
execute as @e[type=#neac_marker_motion:example/test_entitys,distance=..5] run tag @s add NeAcMarkerMotion.target

function neac_marker_motion:

execute as @e[type=#neac_marker_motion:example/test_entitys,tag=NeAcMarkerMotion.target] run tag @s remove NeAcMarkerMotion.target

execute at @s run function neac_marker_motion:example/particle/main

execute if entity @e[tag=NeAcMarkerMotion.hit,limit=1] as @e[tag=NeAcMarkerMotion.hit] run effect give @s instant_damage 1 0 true
execute if entity @e[tag=NeAcMarkerMotion.hit,limit=1] as @e[tag=NeAcMarkerMotion.hit] run tag @s remove NeAcMarkerMotion.hit

scoreboard players add @s neac_value 1

execute if entity @s[scores={neac_value=100..}] run tag @s add NeAcMarkerMotion.Example.end
execute if entity @s[tag=NeAcMarkerMotion.stop] run tag @s add NeAcMarkerMotion.Example.end

execute if entity @s[tag=NeAcMarkerMotion.Example.end] at @s run particle explosion ~ ~ ~ 0 0 0 0 1 force
execute if entity @s[tag=NeAcMarkerMotion.Example.end] at @s run playsound minecraft:entity.shulker_bullet.hurt master @a ~ ~ ~ 5 1.62
execute if entity @s[tag=NeAcMarkerMotion.Example.end] run kill @s