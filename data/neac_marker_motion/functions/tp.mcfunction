

execute at @s unless block ^ ^ ^0.2 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.2] if block ^ ^ ^0.2 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.2
execute at @s unless block ^ ^ ^0.1 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.1] if block ^ ^ ^0.1 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.1
execute at @s unless block ^ ^ ^0.05 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.05] if block ^ ^ ^0.05 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.05
execute at @s unless block ^ ^ ^0.025 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.025] if block ^ ^ ^0.025 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.025
execute at @s unless block ^ ^ ^0.0125 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.0125] if block ^ ^ ^0.0125 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.0125
execute at @s unless block ^ ^ ^0.00625 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.00625] if block ^ ^ ^0.00625 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.00625
execute at @s unless block ^ ^ ^0.003125 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.003125] if block ^ ^ ^0.003125 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.003125
execute at @s unless block ^ ^ ^0.003125 #neac_marker_motion:no_collision run tag @s add NeAcMarkerMotion.tp.blocked
execute at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.003125] if block ^ ^ ^0.003125 #neac_marker_motion:no_collision run tp @s ^ ^ ^0.003125

execute if entity @e[tag=NeAcMarkerMotion.target,limit=1] at @s positioned ~-0.5 ~-0.5 ~-0.5 as @e[dx=0,tag=NeAcMarkerMotion.target] run tag @s add NeAcMarkerMotion.hit
execute as @a[tag=NeAcMarkerMotion.hit,gamemode=spectator] run tag @s remove NeAcMarkerMotion.hit
execute if score #NeAcMarkerMotion.Temporary1 neac_value matches 1 if entity @e[tag=NeAcMarkerMotion.hit,limit=1] run tag @e[tag=NeAcMarkerMotion.me,limit=1] add NeAcMarkerMotion.stopwith.hit
execute if score #NeAcMarkerMotion.Temporary1 neac_value matches 1 if entity @e[tag=NeAcMarkerMotion.hit,limit=1] run tag @s add NeAcMarkerMotion.tp.blocked

scoreboard players add @s neac_value 1
execute if entity @s[tag=!NeAcMarkerMotion.tp.blocked] unless score @s neac_value matches 35.. at @s unless entity @e[tag=NeAcMarkerMotion.this,limit=1,distance=..0.003125] run function neac_marker_motion:tp
