execute unless entity @s[type=marker] run tellraw @a [{"text":"実行者がMarkerではないため実行できません。","color":"#ff0000"}]
execute if entity @s[type=marker,tag=!NeAcMarkerMotion.stop] run function neac_marker_motion:main
