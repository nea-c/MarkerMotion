#> marker_motion:tp/
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:main


# プレイヤーの視線をx軸で反転させた角度
    execute as @e[type=#marker_motion:selector,tag=MarkerMotion.this,limit=1] positioned 0.0 0.0 0.0 positioned ^ ^ ^2 positioned 0.0 ~ ~ positioned ^ ^ ^-1 facing 0.0 0.0 0.0 positioned as @s run tp @s ~ ~ ~ ~ ~

# 初期化
    data modify storage neac: _.tp set value [[{success:0b}],[{success:0b}],[{success:0b}],[{success:0b}],[{success:0b}],[{success:0b}],[{success:0b}],[{success:0b}]]


# 最大ループ回数指定
    scoreboard players set #MarkerMotion.loop neac_value 41
# ループ開始
    execute unless entity @e[type=#marker_motion:selector,tag=MarkerMotion.this,distance=..0.015625,limit=1] positioned ^ ^ ^0.5 run function marker_motion:tp/1
# スコアリセット
    scoreboard players reset #MarkerMotion.loop
