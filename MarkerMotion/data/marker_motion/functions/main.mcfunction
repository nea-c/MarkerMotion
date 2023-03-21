#> marker_motion:main
#
# メイン処理
#
# @within function marker_motion:


# 自身のdataから重力,スピード,重力加速度の合計とかを取得
    # まずは自身のデータを一時ストレージに
        data modify storage neac: _.MarkerMotion set from entity @s data.MarkerMotion
    # 重力加速度
        execute store result score #MarkerMotion.Gravity neac_value run data get storage neac: _.MarkerMotion.gravity 1000
    # 重力合計
        execute store result score #MarkerMotion.GravitySum neac_value run data get storage neac: _.MarkerMotion.GravitySum 1
        # 重力パラメータとはここで加算して格納しちゃう
            execute store result storage neac: _.MarkerMotion.GravitySum int 1 run scoreboard players operation #MarkerMotion.GravitySum neac_value += #MarkerMotion.Gravity neac_value
    # スピード
        execute store result score #MarkerMotion.Speed neac_value run data get storage neac: _.MarkerMotion.speed.amount 100
    # スピード減少量
        execute unless data storage neac: _.MarkerMotion.speed.loss{type:"*"} store result score #MarkerMotion.SpeedLoss neac_value run data get storage neac: _.MarkerMotion.speed.loss.amount 100
        execute if data storage neac: _.MarkerMotion.speed.loss{type:"*"} if data storage neac: _.MarkerMotion.speed.loss.amount store result score #MarkerMotion.SpeedLoss neac_value run data get storage neac: _.MarkerMotion.speed.loss.amount 1000

# 1瞬だけつくようにBounce検知用タグの削除。付与は marker_motion:bounce
    execute if entity @s[tag=MarkerMotion.bounce] run tag @s remove MarkerMotion.bounce
# 接触したブロックが1tickの間前回と同じのにならないようにする
    execute if data storage neac: _.MarkerMotion.BounceDirection run data modify storage neac: _.BounceDirectionDisable set from storage neac: _.MarkerMotion.BounceDirection
    execute if data storage neac: _.MarkerMotion.BounceDirection run data remove storage neac: _.MarkerMotion.BounceDirection
# 到達目標位置を取得してそこまでの間にブロックがあるかチェック
    # その際targetタグがいればヒット判定も返す
        tag @s add MarkerMotion.me
        execute summon marker run function marker_motion:tp/
        tag @s remove MarkerMotion.me

# スピード減少
    # +
        execute if data storage neac: _.MarkerMotion.speed.loss unless data storage neac: _.MarkerMotion.speed.loss{type:"*"} unless score #MarkerMotion.SpeedLoss neac_value matches 0 store result storage neac: _.MarkerMotion.speed.amount double 0.01 run scoreboard players operation #MarkerMotion.Speed neac_value += #MarkerMotion.SpeedLoss neac_value
    # *
        execute if data storage neac: _.MarkerMotion.speed.loss{type:"*"} unless score #MarkerMotion.SpeedLoss neac_value matches 1000 store result storage neac: _.MarkerMotion.speed.amount double 0.00001 run scoreboard players operation #MarkerMotion.Speed neac_value *= #MarkerMotion.SpeedLoss neac_value

    # スピードが0未満になったら0に固定する
        execute if score #MarkerMotion.Speed neac_value matches ..-1 store result storage neac: _.MarkerMotion.speed.amount double 0.01 run scoreboard players set #MarkerMotion.Speed neac_value 0

# スピード0、かつ重力合計が0だったら停止
    execute if score #MarkerMotion.Speed neac_value matches 0 if data storage neac: _.MarkerMotion{GravitySum:0} run tag @s add MarkerMotion.speed.0

# タグ付与
    execute if predicate marker_motion:stop run tag @s add MarkerMotion.stop

# スコアリセット
    scoreboard players reset #MarkerMotion.Speed
    scoreboard players reset #MarkerMotion.SpeedLoss
    scoreboard players reset #MarkerMotion.Gravity
    scoreboard players reset #MarkerMotion.GravitySum

# ストレージデータを自身に返して初期化
    data modify entity @s data.MarkerMotion set from storage neac: _.MarkerMotion
    data remove storage neac: _
