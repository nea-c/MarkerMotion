
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1 store result score #NeAcMarkerMotion.Bounce.Rotation0 neac_value run data get entity @e[tag=NeAcMarkerMotion.this2,limit=1] Rotation[0] 100
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 2 store result score #NeAcMarkerMotion.Bounce.Rotation0 neac_value run data get entity @e[tag=NeAcMarkerMotion.this2,limit=1] Rotation[0] 100
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 5 store result score #NeAcMarkerMotion.Bounce.Rotation0 neac_value run data get entity @e[tag=NeAcMarkerMotion.this2,limit=1] Rotation[0] 100
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 6 store result score #NeAcMarkerMotion.Bounce.Rotation0 neac_value run data get entity @e[tag=NeAcMarkerMotion.this2,limit=1] Rotation[0] 100
execute store result score #NeAcMarkerMotion.Bounce.Rotation1 neac_value run data get entity @e[tag=NeAcMarkerMotion.this2,limit=1] Rotation[1] 100

execute if score #NeAcMarkerMotion.Bounce.Rotation0 neac_value matches 18000.. run scoreboard players remove #NeAcMarkerMotion.Bounce.Rotation0 neac_value 36000
execute if score #NeAcMarkerMotion.Bounce.Rotation0 neac_value matches ..-18000 run scoreboard players add #NeAcMarkerMotion.Bounce.Rotation0 neac_value 36000

execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1..4 run scoreboard players set #NeAcMarkerMotion.Bounce.Temporary1 neac_value -1
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 5..6 run scoreboard players set #NeAcMarkerMotion.Bounce.Temporary1 neac_value 18000

execute if data entity @s data.NeAcMarkerMotion.bounce.e store result score #NeAcMarkerMotion.Bounce.e neac_value run data get entity @s data.NeAcMarkerMotion.bounce.e 1000

execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1..2 store result entity @s Rotation[0] float 0.01 run scoreboard players operation #NeAcMarkerMotion.Bounce.Rotation0 neac_value *= #NeAcMarkerMotion.Bounce.Temporary1 neac_value
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 5..6 store result entity @s Rotation[0] float 0.01 run scoreboard players operation #NeAcMarkerMotion.Bounce.Temporary1 neac_value -= #NeAcMarkerMotion.Bounce.Rotation0 neac_value
execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 3..4 store result entity @s Rotation[1] float 0.01 run scoreboard players get #NeAcMarkerMotion.Bounce.Rotation1 neac_value
execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3..4 store result entity @s Rotation[1] float 0.01 run scoreboard players operation #NeAcMarkerMotion.Bounce.Rotation1 neac_value *= #NeAcMarkerMotion.Bounce.Temporary1 neac_value
tp @s @s

data modify entity @s data.NeAcMarkerMotion.GravitySum set value 0d

execute unless data entity @s data.NeAcMarkerMotion.bounce{count:-1} unless data entity @s data.NeAcMarkerMotion.bounce{count:0} store result entity @s data.NeAcMarkerMotion.bounce.count int 1 run scoreboard players remove #NeAcMarkerMotion.Temporary1 neac_value 1

execute if data entity @s data.NeAcMarkerMotion.bounce.e if score #NeAcMarkerMotion.Bounce.e neac_value matches 0..999 store result entity @s data.NeAcMarkerMotion.speed.amount int 0.001 run scoreboard players operation #NeAcMarkerMotion.Speed neac_value *= #NeAcMarkerMotion.Bounce.e neac_value
execute if data entity @s data.NeAcMarkerMotion.bounce.e if score #NeAcMarkerMotion.Bounce.e neac_value matches 0..999 run scoreboard players operation #NeAcMarkerMotion.Speed neac_value /= #1000 neac_value

execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3..4 if data entity @s data.NeAcMarkerMotion.bounce{g:1b} run function neac_marker_motion:bounce/conside_gravity

tag @s add NeAcMarkerMotion.bounce

#以降のブロック接触処理を実行しないように
    execute if entity @s[tag=!NeAcMarkerMotion.speed.0.bounce] run scoreboard players reset #NeAcMarkerMotion.BlockCheck neac_value

scoreboard players reset #NeAcMarkerMotion.Bounce.e
scoreboard players reset #NeAcMarkerMotion.Bounce.Rotation0
scoreboard players reset #NeAcMarkerMotion.Bounce.Rotation1
scoreboard players reset #NeAcMarkerMotion.Bounce.Temporary1

execute if entity @s[tag=NeAcMarkerMotion.speed.0.bounce] run tag @s remove NeAcMarkerMotion.speed.0.bounce