#> marker_motion:get_vector
#
# ベクトルをもらう
#
# @within function marker_motion:main

# 原点から1m進んだベクトルを取得
    execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^1
    data modify storage neac: marker_motion_pos set from entity @s Pos
    execute store result score #MarkerMotion.Pos1 neac_value run data get storage neac: marker_motion_pos[0] 10000
    execute store result score #MarkerMotion.Pos2 neac_value run data get storage neac: marker_motion_pos[1] 10000
    execute store result score #MarkerMotion.Pos3 neac_value run data get storage neac: marker_motion_pos[2] 10000

# 召喚位置に戻る
    tp @s ~ ~ ~
