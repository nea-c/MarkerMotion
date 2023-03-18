#> marker_motion:get_move
#
# Moveを算出する
#
# @within function marker_motion:main

# ストレージ初期化
    data modify storage neac: _.MarkerMotion.Move set value {Rotation:[0.0f,0.0f],Amount:0.0d}

# 相対で移動して距離を出す
    execute if entity @s[distance=20.48..] run scoreboard players add #MarkerMotion.TMP neac_value 2048
    execute if entity @s[distance=20.48..] positioned as @s run tp @s ^ ^ ^20.48
    execute if entity @s[distance=10.24..] run scoreboard players add #MarkerMotion.TMP neac_value 1024
    execute if entity @s[distance=10.24..] positioned as @s run tp @s ^ ^ ^10.24
    execute if entity @s[distance=5.12..] run scoreboard players add #MarkerMotion.TMP neac_value 512
    execute if entity @s[distance=5.12..] positioned as @s run tp @s ^ ^ ^5.12
    execute if entity @s[distance=2.56..] run scoreboard players add #MarkerMotion.TMP neac_value 256
    execute if entity @s[distance=2.56..] positioned as @s run tp @s ^ ^ ^2.56
    execute if entity @s[distance=1.28..] run scoreboard players add #MarkerMotion.TMP neac_value 128
    execute if entity @s[distance=1.28..] positioned as @s run tp @s ^ ^ ^1.28
    execute if entity @s[distance=0.64..] run scoreboard players add #MarkerMotion.TMP neac_value 64
    execute if entity @s[distance=0.64..] positioned as @s run tp @s ^ ^ ^0.64
    execute if entity @s[distance=0.32..] run scoreboard players add #MarkerMotion.TMP neac_value 32
    execute if entity @s[distance=0.32..] positioned as @s run tp @s ^ ^ ^0.32
    execute if entity @s[distance=0.16..] run scoreboard players add #MarkerMotion.TMP neac_value 16
    execute if entity @s[distance=0.16..] positioned as @s run tp @s ^ ^ ^0.16
    execute if entity @s[distance=0.08..] run scoreboard players add #MarkerMotion.TMP neac_value 8
    execute if entity @s[distance=0.08..] positioned as @s run tp @s ^ ^ ^0.08
    execute if entity @s[distance=0.04..] run scoreboard players add #MarkerMotion.TMP neac_value 4
    execute if entity @s[distance=0.04..] positioned as @s run tp @s ^ ^ ^0.04
    execute if entity @s[distance=0.02..] run scoreboard players add #MarkerMotion.TMP neac_value 2
    execute if entity @s[distance=0.02..] positioned as @s run tp @s ^ ^ ^0.02
    execute if entity @s[distance=0.01..] run scoreboard players add #MarkerMotion.TMP neac_value 1
    execute if entity @s[distance=0.01..] positioned as @s run tp @s ^ ^ ^0.01

# 移動距離スコアをストレージへ
    execute store result storage neac: _.MarkerMotion.Move.Amount double 0.01 run scoreboard players get #MarkerMotion.TMP neac_value

# 向きをこのfunctionの実行角度にしてストレージへ
    tp @s ~ ~ ~ ~ ~
    data modify storage neac: _.MarkerMotion.Move.Rotation set from entity @s Rotation

# スコアリセット
    scoreboard players reset #MarkerMotion.TMP

# kill
    kill @s