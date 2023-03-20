#> marker_motion:bounce/
#
# ブロックに当たった判定時、向きを変えたりする処理
#
# @within function marker_motion:block

# 跳ねたことを1tick検知できるようにするためのタグ付与
tag @s add MarkerMotion.bounce

# 接触方向によって幾何学で向きを変える (移動してきた向きではなくてライブラリ実行時の向きを反転する)
    execute if score #MarkerMotion.BlockCheck neac_value matches 1..2 rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^-2 positioned 0.0 ~ ~ positioned ^ ^ ^1 facing 0.0 0.0 0.0 positioned as @s run tp @s ~ ~ ~ ~ ~
    execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^-2 positioned ~ 0.0 ~ positioned ^ ^ ^1 facing 0.0 0.0 0.0 positioned as @s run tp @s ~ ~ ~ ~ ~
    execute if score #MarkerMotion.BlockCheck neac_value matches 5..6 rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^-2 positioned ~ ~ 0.0 positioned ^ ^ ^1 facing 0.0 0.0 0.0 positioned as @s run tp @s ~ ~ ~ ~ ~

# バウンス回数が無限(-1)、0でない時にバウンス回数を1減らす
    execute unless data storage neac: _.MarkerMotion.bounce{count:-2} unless data storage neac: _.MarkerMotion.bounce{count:-1} unless data storage neac: _.MarkerMotion.bounce{count:0} store result storage neac: _.MarkerMotion.bounce.count int 1 run scoreboard players remove #MarkerMotion.Bounce.Count neac_value 1

# 反発係数があればそれを計算して返却
    execute if data storage neac: _.MarkerMotion.bounce.e store result score #MarkerMotion.Bounce.e neac_value run data get storage neac: _.MarkerMotion.bounce.e 1000
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 store result storage neac: _.MarkerMotion.speed.amount double 0.00001 run scoreboard players operation #MarkerMotion.Speed neac_value *= #MarkerMotion.Bounce.e neac_value
    execute if data storage neac: _.MarkerMotion.bounce.e unless score #MarkerMotion.Bounce.e neac_value matches 1000 run scoreboard players operation #MarkerMotion.Speed neac_value /= #1000 neac_value

# 重力を考慮しない場合
    # 重力合計をリセット
        execute unless data storage neac: _.MarkerMotion.bounce{g:1b} run data modify storage neac: _.MarkerMotion.GravitySum set value 0

# 重力を考慮する場合
    execute if data storage neac: _.MarkerMotion.bounce{g:1b} run function marker_motion:bounce/conside_gravity

# 以降のブロック接触処理を実行しないように
    execute unless data storage neac: _.MarkerMotion.bounce{count:-2} if entity @s[tag=!MarkerMotion.speed.0] run scoreboard players reset #MarkerMotion.BlockCheck neac_value

# スコアリセット
    scoreboard players reset #MarkerMotion.Bounce.e
