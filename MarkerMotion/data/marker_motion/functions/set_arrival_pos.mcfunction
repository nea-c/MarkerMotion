#> marker_motion:set_arrival_pos
#
# 到達目標位置をへ自身を移動させる
#
# @within function marker_motion:main

# 必要なタグ付与
    tag @s add MarkerMotion.this

# bounce.gオン時、移動前Y座標取得
    execute if data storage neac: _.MarkerMotion.bounce{g:1b} store result score #MarkerMotion.Bounce.CG.TMP1 neac_value run data get entity @s Pos[1] 1000000

# 相対で移動
    scoreboard players operation #MarkerMotion.TMP neac_value = #MarkerMotion.Speed neac_value

    execute if score #MarkerMotion.TMP neac_value matches 2048.. positioned as @s run tp @s ^ ^ ^20.48
    execute if score #MarkerMotion.TMP neac_value matches 2048.. run scoreboard players remove #MarkerMotion.TMP neac_value 2048
    execute if score #MarkerMotion.TMP neac_value matches 1024.. positioned as @s run tp @s ^ ^ ^10.24
    execute if score #MarkerMotion.TMP neac_value matches 1024.. run scoreboard players remove #MarkerMotion.TMP neac_value 1024
    execute if score #MarkerMotion.TMP neac_value matches 512.. positioned as @s run tp @s ^ ^ ^5.12
    execute if score #MarkerMotion.TMP neac_value matches 512.. run scoreboard players remove #MarkerMotion.TMP neac_value 512
    execute if score #MarkerMotion.TMP neac_value matches 256.. positioned as @s run tp @s ^ ^ ^2.56
    execute if score #MarkerMotion.TMP neac_value matches 256.. run scoreboard players remove #MarkerMotion.TMP neac_value 256
    execute if score #MarkerMotion.TMP neac_value matches 128.. positioned as @s run tp @s ^ ^ ^1.28
    execute if score #MarkerMotion.TMP neac_value matches 128.. run scoreboard players remove #MarkerMotion.TMP neac_value 128
    execute if score #MarkerMotion.TMP neac_value matches 64.. positioned as @s run tp @s ^ ^ ^0.64
    execute if score #MarkerMotion.TMP neac_value matches 64.. run scoreboard players remove #MarkerMotion.TMP neac_value 64
    execute if score #MarkerMotion.TMP neac_value matches 32.. positioned as @s run tp @s ^ ^ ^0.32
    execute if score #MarkerMotion.TMP neac_value matches 32.. run scoreboard players remove #MarkerMotion.TMP neac_value 32
    execute if score #MarkerMotion.TMP neac_value matches 16.. positioned as @s run tp @s ^ ^ ^0.16
    execute if score #MarkerMotion.TMP neac_value matches 16.. run scoreboard players remove #MarkerMotion.TMP neac_value 16
    execute if score #MarkerMotion.TMP neac_value matches 8.. positioned as @s run tp @s ^ ^ ^0.08
    execute if score #MarkerMotion.TMP neac_value matches 8.. run scoreboard players remove #MarkerMotion.TMP neac_value 8
    execute if score #MarkerMotion.TMP neac_value matches 4.. positioned as @s run tp @s ^ ^ ^0.04
    execute if score #MarkerMotion.TMP neac_value matches 4.. run scoreboard players remove #MarkerMotion.TMP neac_value 4
    execute if score #MarkerMotion.TMP neac_value matches 2.. positioned as @s run tp @s ^ ^ ^0.02
    execute if score #MarkerMotion.TMP neac_value matches 2.. run scoreboard players remove #MarkerMotion.TMP neac_value 2
    execute if score #MarkerMotion.TMP neac_value matches 1.. positioned as @s run tp @s ^ ^ ^0.01
    execute if score #MarkerMotion.TMP neac_value matches 1.. run scoreboard players remove #MarkerMotion.TMP neac_value 1

# ifに引っかからない対策で少しだけ後ろに移動しておく
    execute positioned as @s run tp @s ^ ^ ^-0.0000152587890625

# 直線移動後のY座標取得
    execute store result score #MarkerMotion.TMP neac_value run data get entity @s Pos[1] 1000000
    # GravitySumが0でなければ移動後のY座標から重力分を引いた座標に移動する
        execute unless score #MarkerMotion.GravitySum neac_value matches 0 store result entity @s Pos[1] double 0.000001 run scoreboard players operation #MarkerMotion.TMP neac_value -= #MarkerMotion.GravitySum neac_value
    # bounce.gオン時、到達目標Y座標と移動前Y座標を減算してMotion値にしておく
        execute if data storage neac: _.MarkerMotion.bounce{g:1b} store result score #MarkerMotion.Bounce.CG.TMP1 neac_value run scoreboard players operation #MarkerMotion.TMP neac_value -= #MarkerMotion.Bounce.CG.TMP1 neac_value

# スコアリセット
    scoreboard players reset #MarkerMotion.TMP