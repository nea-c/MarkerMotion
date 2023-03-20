
execute as @e[type=#marker_motion_example:test_entitys,distance=..5] run tag @s add MarkerMotion.target
function #marker_motion:

#パーティクル出す
execute at @s run function marker_motion_example:particle/main

execute if entity @s[tag=MarkerMotion.on_block,tag=!MarkerMotion.on_block.wall] at @s run function marker_motion_example:tick/3_bounce

execute as @e[type=#marker_motion_example:test_entitys,tag=MarkerMotion.target] run tag @s remove MarkerMotion.target

execute if entity @e[tag=MarkerMotion.hit,limit=1] as @e[tag=MarkerMotion.hit] run damage @s 0.000000000000000000000000000000000000000000001 out_of_world
execute if entity @e[tag=MarkerMotion.hit,limit=1] as @e[tag=MarkerMotion.hit] run tag @s remove MarkerMotion.hit

scoreboard players add @s neac_value 1

execute if entity @s[scores={neac_value=100..}] run tag @s add MarkerMotion.Example.end
execute if entity @s[tag=MarkerMotion.stop] run tag @s add MarkerMotion.Example.end

execute if entity @s[tag=MarkerMotion.Example.end] at @s run particle explosion ~ ~ ~ 0 0 0 0 1 force
execute if entity @s[tag=MarkerMotion.Example.end] at @s run playsound minecraft:entity.shulker_bullet.hurt master @a ~ ~ ~ 5 1.62
execute if entity @s[tag=MarkerMotion.Example.end] run scoreboard players reset @s neac_value
execute if entity @s[tag=MarkerMotion.Example.end] run kill @s