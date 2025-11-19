


execute if entity @s[distance=..0.1] positioned as @s run function marker_motion_example:particle/render
execute unless entity @s[distance=..0.1] run function marker_motion_example:particle/render


execute unless entity @s[distance=..0.1] positioned ^ ^ ^0.1 run function marker_motion_example:particle/loop