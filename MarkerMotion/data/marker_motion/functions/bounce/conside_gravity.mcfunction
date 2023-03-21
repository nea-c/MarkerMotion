#> marker_motion:bounce/conside_gravity
#
# Y方向でぶつかって重力を考慮してバウンドするときの処理
#
# @within function marker_motion:bounce/


# 反発係数があれば重力合計値を計算して返却
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 store result storage neac: _.MarkerMotion.GravitySum int 0.001 run scoreboard players operation #MarkerMotion.GravitySum neac_value *= #MarkerMotion.Bounce.e neac_value
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 run scoreboard players operation #MarkerMotion.GravitySum neac_value /= #1000 neac_value

# Y方向接触時、重力合計を反転
    execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 store result storage neac: _.MarkerMotion.GravitySum int -1 run scoreboard players get #MarkerMotion.GravitySum neac_value
