#data.NeAcMarkerMotion.Motionのデータからパーティクルを発生させる処理

execute unless entity @e[tag=NeAcMarkerMotion.example.vector,limit=1] run summon marker 0.0 0.0 0.0 {Tags:["NeAcMarkerMotion.example.vector"]}
tp @e[tag=NeAcMarkerMotion.example.vector] 0.0 0.0 0.0 ~ ~

data modify entity @e[tag=NeAcMarkerMotion.example.vector,limit=1,x=0,y=0,z=0,distance=..1] Pos set from entity @s data.NeAcMarkerMotion.Motion

summon marker 0.0 0.0 0.0 {Tags:["NeAcMarkerMotion.example.vector_amount"]}
execute positioned 0.0 0.0 0.0 facing entity @e[tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] feet run tp @e[tag=NeAcMarkerMotion.example.vector_amount] ~ ~ ~ ~ ~
execute at @e[tag=NeAcMarkerMotion.example.vector_amount] if entity @e[distance=8..16,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run scoreboard players add #NeAcMarkerMotionParticleMA neac_value 8
execute as @e[tag=NeAcMarkerMotion.example.vector_amount] at @s if entity @e[distance=8..16,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run tp @s ^ ^ ^8
execute at @e[tag=NeAcMarkerMotion.example.vector_amount] if entity @e[distance=4..8,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run scoreboard players add #NeAcMarkerMotionParticleMA neac_value 5
execute as @e[tag=NeAcMarkerMotion.example.vector_amount] at @s if entity @e[distance=4..8,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run tp @s ^ ^ ^4
execute at @e[tag=NeAcMarkerMotion.example.vector_amount] if entity @e[distance=2..4,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run scoreboard players add #NeAcMarkerMotionParticleMA neac_value 2
execute as @e[tag=NeAcMarkerMotion.example.vector_amount] at @s if entity @e[distance=2..4,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run tp @s ^ ^ ^2
execute at @e[tag=NeAcMarkerMotion.example.vector_amount] if entity @e[distance=1..2,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run scoreboard players add #NeAcMarkerMotionParticleMA neac_value 1
execute as @e[tag=NeAcMarkerMotion.example.vector_amount] at @s if entity @e[distance=1..2,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run tp @s ^ ^ ^1
execute at @e[tag=NeAcMarkerMotion.example.vector_amount] if entity @e[distance=0.5..1,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run scoreboard players add #NeAcMarkerMotionParticleMA neac_value 1
execute as @e[tag=NeAcMarkerMotion.example.vector_amount] at @s if entity @e[distance=0.5..1,tag=NeAcMarkerMotion.example.vector,limit=1,sort=nearest] run tp @s ^ ^ ^0.5

execute rotated as @e[tag=NeAcMarkerMotion.example.vector_amount,limit=1] run function neac_marker_motion:example/particle/render
kill @e[tag=NeAcMarkerMotion.example.vector_amount]

scoreboard players reset #NeAcMarkerMotionParticleMA

kill @e[tag=NeAcMarkerMotion.example.vector]