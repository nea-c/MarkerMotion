
function neac_marker_motion:

#パーティクル出す
execute at @s run function neac_marker_motion:example/particle/main

scoreboard players add @s neac_value 1

execute if entity @s[scores={neac_value=100..}] run tag @s add NeAcMarkerMotion.Example.end
execute if entity @s[tag=NeAcMarkerMotion.stop] run tag @s add NeAcMarkerMotion.Example.end

execute if entity @s[tag=NeAcMarkerMotion.Example.end] at @s run particle explosion ~ ~ ~ 0 0 0 0 1 force
execute if entity @s[tag=NeAcMarkerMotion.Example.end] at @s run playsound minecraft:entity.shulker_bullet.hurt master @a ~ ~ ~ 5 1.62
execute if entity @s[tag=NeAcMarkerMotion.Example.end] run scoreboard players reset @s neac_value
execute if entity @s[tag=NeAcMarkerMotion.Example.end] run kill @s