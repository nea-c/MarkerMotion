#> marker_motion:
#
# 実行者がmarkerであるかを検知して通知/処理実行を切り替え
#
# @within tag/function marker_motion:

    execute unless entity @s[type=marker] run tellraw @a [{"text":"実行者がMarkerではないため実行できません。","color":"#ff0000"}]
    execute if entity @s[type=marker,tag=!MarkerMotion.stop] run function marker_motion:main
