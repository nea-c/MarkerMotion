#> marker_motion:bounce/
#
# ブロックに当たった判定時、向きを変えたりする処理
#
# @within function marker_motion:main

# 衝突方向に応じて計算する用の値をもらってくる
    execute unless score #MarkerMotion.BlockCheck neac_value matches 3..4 store result score #MarkerMotion.Bounce.Rotation0 neac_value run data get entity @e[tag=MarkerMotion.this2,limit=1] Rotation[0] 100
    # X軸方向はいろいろあるので必ずもらう
        execute store result score #MarkerMotion.Bounce.Rotation1 neac_value run data get entity @e[tag=MarkerMotion.this2,limit=1] Rotation[1] 100

# 計算
    execute if score #MarkerMotion.Bounce.Rotation0 neac_value matches 18000.. run scoreboard players remove #MarkerMotion.Bounce.Rotation0 neac_value 36000
    execute if score #MarkerMotion.Bounce.Rotation0 neac_value matches ..-18000 run scoreboard players add #MarkerMotion.Bounce.Rotation0 neac_value 36000

    execute if score #MarkerMotion.BlockCheck neac_value matches 1..4 run scoreboard players set #MarkerMotion.Bounce.Temporary1 neac_value -1
    execute if score #MarkerMotion.BlockCheck neac_value matches 5..6 run scoreboard players set #MarkerMotion.Bounce.Temporary1 neac_value 18000

    # 反発係数があれば受け取る
        execute if data storage neac: marker_motion.bounce.e store result score #MarkerMotion.Bounce.e neac_value run data get storage neac: marker_motion.bounce.e 1000

    execute if score #MarkerMotion.BlockCheck neac_value matches 1..2 store result entity @s Rotation[0] float 0.01 run scoreboard players operation #MarkerMotion.Bounce.Rotation0 neac_value *= #MarkerMotion.Bounce.Temporary1 neac_value
    execute if score #MarkerMotion.BlockCheck neac_value matches 5..6 store result entity @s Rotation[0] float 0.01 run scoreboard players operation #MarkerMotion.Bounce.Temporary1 neac_value -= #MarkerMotion.Bounce.Rotation0 neac_value
    execute unless score #MarkerMotion.BlockCheck neac_value matches 3..4 store result entity @s Rotation[1] float 0.01 run scoreboard players get #MarkerMotion.Bounce.Rotation1 neac_value
    execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 store result entity @s Rotation[1] float 0.01 run scoreboard players operation #MarkerMotion.Bounce.Rotation1 neac_value *= #MarkerMotion.Bounce.Temporary1 neac_value

# 重力合計をリセット
    data modify storage neac: marker_motion.GravitySum set value 0d

# バウンス回数が無限(-1)、0でない時にバウンス回数を1減らす
    execute unless data storage neac: marker_motion.bounce{count:-1} unless data storage neac: marker_motion.bounce{count:0} store result storage neac: marker_motion.bounce.count int 1 run scoreboard players remove #MarkerMotion.Temporary1 neac_value 1

# 反発係数があったらそれを計算して代入する
    execute if data storage neac: marker_motion.bounce.e if score #MarkerMotion.Bounce.e neac_value matches 0..999 store result storage neac: marker_motion.speed.amount int 0.001 run scoreboard players operation #MarkerMotion.Speed neac_value *= #MarkerMotion.Bounce.e neac_value
    execute if data storage neac: marker_motion.bounce.e if score #MarkerMotion.Bounce.e neac_value matches 0..999 run scoreboard players operation #MarkerMotion.Speed neac_value /= #1000 neac_value

# Y方向の時、かつ重力を考慮する場合は専用処理へ
    execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 if data storage neac: marker_motion.bounce{g:1b} run function marker_motion:bounce/conside_gravity

tag @s add MarkerMotion.bounce

# 以降のブロック接触処理を実行しないように
    execute if entity @s[tag=!MarkerMotion.speed.0.bounce] run scoreboard players reset #MarkerMotion.BlockCheck neac_value

# スコアリセット
    scoreboard players reset #MarkerMotion.Bounce.e
    scoreboard players reset #MarkerMotion.Bounce.Rotation0
    scoreboard players reset #MarkerMotion.Bounce.Rotation1
    scoreboard players reset #MarkerMotion.Bounce.Temporary1

# 一時処理用タグ削除
    execute if entity @s[tag=MarkerMotion.speed.0.bounce] run tag @s remove MarkerMotion.speed.0.bounce