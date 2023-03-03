#> marker_motion:tp/
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:main


# 向き取得のために向きのみ変更
    execute as @e[tag=MarkerMotion.this,limit=1] positioned as @s run tp @s ~ ~ ~ ~ ~


# 最大ループ回数指定
    scoreboard players set #MarkerMotion.loop neac_value 25
# ループ開始
    execute unless entity @e[tag=MarkerMotion.this,distance=..0.008,limit=1] positioned ^ ^ ^0.512 run function marker_motion:tp/1024
# スコアリセット
    scoreboard players reset #MarkerMotion.loop

