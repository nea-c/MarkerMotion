#> marker_motion:conside_gravity/get_vector
#
# ベクトルをもらう
#
# @within function marker_motion:conside_gravity/


# ベクトルを取得
    execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^1
    execute store result score #MarkerMotion.Bounce.CG.YVec neac_value run data get entity @s Pos[1] 10000
    scoreboard players operation #MarkerMotion.Bounce.CG.YVec neac_value *= #MarkerMotion.Speed neac_value

# 実行位置に戻る
    tp @s ~ ~ ~
