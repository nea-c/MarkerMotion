#> marker_motion:bounce/conside_gravity
#
# Y方向でぶつかって重力を考慮してバウンドするときの処理
#
# @within function marker_motion:bounce/

# 以前のブロック接触時の重力合計があれば取得
    execute if data storage neac: _.MarkerMotion.GSumAtCGPrevBounce store result score #MarkerMotion.Bounce.CG.GSumAtCGPrevBounce neac_value run data get storage neac: _.MarkerMotion.GSumAtCGPrevBounce 1.0
    # 以前のブロック接触時の重力合計と現在の重力合計の差分誤差が少なければ止まったとみなす
    execute if data storage neac: _.MarkerMotion.GSumAtCGPrevBounce run scoreboard players operation #MarkerMotion.Bounce.CG.GSumAtCGPrevBounce neac_value -= #MarkerMotion.GravitySum neac_value
    execute if data storage neac: _.MarkerMotion.GSumAtCGPrevBounce if score #MarkerMotion.Speed neac_value matches ..0 if score #MarkerMotion.Bounce.CG.GSumAtCGPrevBounce neac_value matches -1..1 run tag @s add MarkerMotion.speed.0.bounce

# 重力合計をGSumAtCGPrevBounceに保存
    execute store result storage neac: _.MarkerMotion.GSumAtCGPrevBounce int 1 run scoreboard players get #MarkerMotion.GravitySum neac_value

# 反発係数があれば重力合計値を計算して返却
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 store result storage neac: _.MarkerMotion.GravitySum int 0.001 run scoreboard players operation #MarkerMotion.GravitySum neac_value *= #MarkerMotion.Bounce.e neac_value
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 run scoreboard players operation #MarkerMotion.GravitySum neac_value /= #1000 neac_value

# Y方向接触時、重力合計を反転
    execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 store result storage neac: _.MarkerMotion.GravitySum int -1 run scoreboard players get #MarkerMotion.GravitySum neac_value

# スコアリセット
    scoreboard players reset #MarkerMotion.Bounce.CG.GSumAtCGPrevBounce