#> marker_motion:get_vector
#
# ベクトルをもらう
#
# @within function marker_motion:main

# 必要なタグとかをつける
    data merge entity @s {Tags:["MarkerMotion.this","MarkerMotion.thisP","MarkerMotion.this.All"],item:{id:"stone",Count:1b},view_range:0f}

# Motionの初期化
    execute unless data storage neac: _.MarkerMotion.Motion run data modify storage neac: _.MarkerMotion.Motion set value [0d,0d,0d]

# ベクトルを取得
    execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^1
    data modify storage neac: _.Vector set from entity @s Pos

# 召喚位置に戻る
    tp @s ~ ~ ~


# Motin値へ
    # X
        execute store result score #MarkerMotion.Vec neac_value run data get storage neac: _.Vector[0] 10000
        execute store result storage neac: _.MarkerMotion.Motion[0] double 0.000001 run scoreboard players operation #MarkerMotion.Vec neac_value *= #MarkerMotion.Speed neac_value
    # Y
        execute store result score #MarkerMotion.Vec neac_value run data get storage neac: _.Vector[1] 10000
        scoreboard players operation #MarkerMotion.Vec neac_value *= #MarkerMotion.Speed neac_value
        # 重力分を減算してから処理
            execute store result storage neac: _.MarkerMotion.Motion[1] double 0.000001 run scoreboard players operation #MarkerMotion.Vec neac_value -= #MarkerMotion.GravitySum neac_value
    # Z
        execute store result score #MarkerMotion.Vec neac_value run data get storage neac: _.Vector[2] 10000
        execute store result storage neac: _.MarkerMotion.Motion[2] double 0.000001 run scoreboard players operation #MarkerMotion.Vec neac_value *= #MarkerMotion.Speed neac_value
    # スコアリセット
        scoreboard players reset #MarkerMotion.Vec


# 現在位置+モーション
    # X
        execute store result score #MarkerMotion.Pos neac_value run data get storage neac: _.Pos[0] 10000
        execute store result score #MarkerMotion.Motion neac_value run data get storage neac: _.MarkerMotion.Motion[0] 10000
        execute store result storage neac: _.Pos[0] double 0.0001 run scoreboard players operation #MarkerMotion.Pos neac_value += #MarkerMotion.Motion neac_value
    # Y
        execute store result score #MarkerMotion.Pos neac_value run data get storage neac: _.Pos[1] 10000
        execute store result score #MarkerMotion.Motion neac_value run data get storage neac: _.MarkerMotion.Motion[1] 10000
        execute store result storage neac: _.Pos[1] double 0.0001 run scoreboard players operation #MarkerMotion.Pos neac_value += #MarkerMotion.Motion neac_value
    # Z
        execute store result score #MarkerMotion.Pos neac_value run data get storage neac: _.Pos[2] 10000
        execute store result score #MarkerMotion.Motion neac_value run data get storage neac: _.MarkerMotion.Motion[2] 10000
        execute store result storage neac: _.Pos[2] double 0.0001 run scoreboard players operation #MarkerMotion.Pos neac_value += #MarkerMotion.Motion neac_value
    # スコアリセット
        scoreboard players reset #MarkerMotion.Pos
        scoreboard players reset #MarkerMotion.Motion
    # 代入
        data modify entity @e[tag=MarkerMotion.this,limit=1] Pos set from storage neac: _.Pos