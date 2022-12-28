#> marker_motion:main
#
# メイン処理
#
# Markerのdata.MarkerMotion内に speed:{amount:150,loss:{amount:0.950,type:"multiply"}},gravity:392.00,bounce:{count:2,e:0.950,g:1b},stopwith:{hit:1b,block:1b} のように記述
#
## 設定項目
#   speed : 速度関連 - (下に子パラメータ
#       amount : 初期速度 (この数値は自動的に変動します) [整数値]
#       loss : tick毎に減少していく量 - (下に子パラメータ
#           amount : 量。typeパラメータによって効果が異なる。
#           type : amountの計算方法を変更する。 - (下にタイプ一覧
#               "constant" : 減算で計算します [整数値] 9なら9損失
#               "multiply" : 倍率で計算します [小数値,1/1000] 0.9なら10%損失
#   gravity : 重力の強さ (98の倍数が比較的決めやすくておすすめ) [小数値,1/100]
#   bounce : 跳ね返りの実装 - (下に子パラメータ
#       count : 跳ねる回数。-1で無限。 [整数値]
#       e : 跳ねたときに減少するスピードの量。倍率で計算します。 [小数値,1/1000] 0.9なら10%損失
#       g : 重力での加速を考慮して跳ねます。true,falseで入力も可。 [真偽値]
#   stopwith : 途中で移動を停止する条件を指定する。 - (下に子パラメータ
#       hit : ヒットしたエンティティがいた時。true,falseで入力も可。 [真偽値]
#       block : ブロックに接触したとき。true,falseで入力も可。 [真偽値]
#
## 設定項目に関して
#   data.MarkerMotion.speed.amountのみで動作します。
#   小数値はgravity以外は第3位まで、gravityは第2位まで設定できます。
#
## 返りタグ
#   MarkerMotion.on_block : ブロックに接触した時 (跳ねた場合は付与されません)
#   MarkerMotion.on_block.wall , MarkerMotion.on_block.y , MarkerMotion.on_block.[方角] : ブロックに接触した方角やカテゴリ (MarkerMotion.on_blockがない場合は付与されません)
#   MarkerMotion.speed.0 : スピードが0になった時
#   MarkerMotion.stopwith.hit : data.stopwith.hitがtrueかつ、hitタグを付与したエンティティがいた時
#   MarkerMotion.stop : 移動処理(このfunction)が実行されないようになるタグ。MarkerMotion.on_block,MarkerMotion.stopwith.hit,MarkerMotion.speed.0のいずれかのタグがあれば必ず付与されています。
#
## 返りNBT
#   data.MarkerMotion.Motion : 移動量 (この値使って綺麗な繋がったパーティクル出したりとかできるかもしれない)
#   data.MarkerMotion.GravitySum : 重力の合計 (1秒毎にリセットとかで変な挙動できるかもしれない)
#
## 当たり判定に関して
#   このライブラリを呼ぶ前に判定に入れたいエンティティに対しtargetタグを付与します。
#   当たり判定はヒットボックスサイズで検知され、hitタグを返します。
#   付与された,付与したタグは必ず削除するようにしてください。
#
## tag_remove.mcfunction
#   このライブラリで自動的に付与されるタグを全て剥がすfunctionです。
#   実行者はそれらのタグがついたマーカーに必ず変更してください。
#
# @within function marker_motion:


# ベクトル、到達目標位置用の取得に使うマーカー
    summon marker ~ ~ ~ {Tags:["MarkerMotion.this","MarkerMotion.thisP","MarkerMotion.this.All"]}

# ベクトル取得
    execute positioned 0.0 0.0 0.0 rotated as @s run tp @e[tag=MarkerMotion.this,limit=1] ^ ^ ^1
    data modify storage neac: marker_motion_pos set from entity @e[tag=MarkerMotion.this,limit=1] Pos
    execute store result score #MarkerMotion.Pos1 neac_value run data get storage neac: marker_motion_pos[0] 10000
    execute store result score #MarkerMotion.Pos2 neac_value run data get storage neac: marker_motion_pos[1] 10000
    execute store result score #MarkerMotion.Pos3 neac_value run data get storage neac: marker_motion_pos[2] 10000

# 自身のdataから重力,スピード,重力加速度の合計とかを取得
    # まずは自身のデータを一時ストレージに
        data modify storage neac: marker_motion set from entity @s data.MarkerMotion
        data modify storage neac: marker_motion_pos set from entity @s Pos
    # 重力
        execute store result score #MarkerMotion.Gravity neac_value run data get storage neac: marker_motion.gravity 100
    # 重力加速度
        execute store result score #MarkerMotion.GravitySum neac_value run data get storage neac: marker_motion.GravitySum
    # スピード
        execute store result score #MarkerMotion.Speed neac_value run data get storage neac: marker_motion.speed.amount
    # スピード減少量
        execute unless data storage neac: marker_motion.speed.loss{type:"multiply"} store result score #MarkerMotion.SpeedLoss neac_value run data get storage neac: marker_motion.speed.loss.amount
        execute if data storage neac: marker_motion.speed.loss{type:"multiply"} if data storage neac: marker_motion.speed.loss.amount store result score #MarkerMotion.SpeedLoss neac_value run data get storage neac: marker_motion.speed.loss.amount 1000
    # Motionの初期化
        execute unless data storage neac: marker_motion.Motion run data modify storage neac: marker_motion.Motion set value [0d,0d,0d]

# X
    scoreboard players operation #MarkerMotion.Pos1 neac_value *= #MarkerMotion.Speed neac_value
    execute store result storage neac: marker_motion.Motion[0] double 0.0001 run scoreboard players operation #MarkerMotion.Pos1 neac_value /= #100 neac_value
# Y
    scoreboard players operation #MarkerMotion.Pos2 neac_value *= #MarkerMotion.Speed neac_value
    # 重力分を減算してから処理
        scoreboard players operation #MarkerMotion.GravitySum neac_value += #MarkerMotion.Gravity neac_value
        scoreboard players operation #MarkerMotion.Pos2 neac_value -= #MarkerMotion.GravitySum neac_value
        scoreboard players operation #MarkerMotion.Bounce.CG.YVec.Temporary1 neac_value = #MarkerMotion.Pos2 neac_value
    execute store result storage neac: marker_motion.Motion[1] double 0.0001 run scoreboard players operation #MarkerMotion.Pos2 neac_value /= #100 neac_value
    # 重力加速度をnbtに格納
        execute store result storage neac: marker_motion.GravitySum int 1 run scoreboard players get #MarkerMotion.GravitySum neac_value

# Z
    scoreboard players operation #MarkerMotion.Pos3 neac_value *= #MarkerMotion.Speed neac_value
    execute store result storage neac: marker_motion.Motion[2] double 0.0001 run scoreboard players operation #MarkerMotion.Pos3 neac_value /= #100 neac_value

# 現在位置とモーションの数値を取得して計算
    # 現在位置
        execute store result score #MarkerMotion.Pos1 neac_value run data get storage neac: marker_motion_pos[0] 10000
        execute store result score #MarkerMotion.Pos2 neac_value run data get storage neac: marker_motion_pos[1] 10000
        execute store result score #MarkerMotion.Pos3 neac_value run data get storage neac: marker_motion_pos[2] 10000
    # モーション値
        execute store result score #MarkerMotion.Motion1 neac_value run data get storage neac: marker_motion.Motion[0] 10000
        execute store result score #MarkerMotion.Motion2 neac_value run data get storage neac: marker_motion.Motion[1] 10000
        execute store result score #MarkerMotion.Motion3 neac_value run data get storage neac: marker_motion.Motion[2] 10000

# 到達目標位置にベクトル取得時に使ったマーカーを使いまわして配置
    # その際離れているとPosが代入できないっぽいので一度実行位置にTP
        tp @e[tag=MarkerMotion.this,limit=1] ~ ~ ~

    # 計算&代入
        execute store result storage neac: marker_motion_pos[0] double 0.0001 run scoreboard players operation #MarkerMotion.Pos1 neac_value += #MarkerMotion.Motion1 neac_value
        execute store result storage neac: marker_motion_pos[1] double 0.0001 run scoreboard players operation #MarkerMotion.Pos2 neac_value += #MarkerMotion.Motion2 neac_value
        execute store result storage neac: marker_motion_pos[2] double 0.0001 run scoreboard players operation #MarkerMotion.Pos3 neac_value += #MarkerMotion.Motion3 neac_value
        data modify entity @e[tag=MarkerMotion.this,limit=1] Pos set from storage neac: marker_motion_pos

# 現在位置と到達目標位置の間にブロックがあるかチェック
    # 現在位置用のマーカー召喚
        summon marker ~ ~ ~ {Tags:["MarkerMotion.this2","MarkerMotion.thisP","MarkerMotion.this.All"]}
    # 現在位置用マーカーを到達目標位置に向ける
        execute as @e[tag=MarkerMotion.this2,limit=1] at @s facing entity @e[tag=MarkerMotion.this,sort=furthest,limit=1] feet run tp @s ~ ~ ~ ~ ~
    # function再起で到達目標位置までの間にブロックがあるかチェック
    # その際targetタグがいればヒット判定を返す　また、stopwith.hitがtrueであればMarkerMotion.stopwith.hitを返す
        tag @s add MarkerMotion.me
        execute as @e[tag=MarkerMotion.this2,limit=1] run function marker_motion:tp/
        tag @s remove MarkerMotion.me
        # 現在位置と到達目標位置の距離が限りなく近い場合は間にブロックがなかったことにして、下のnearestTPの判定にならないように遠ざける
            execute as @e[tag=MarkerMotion.this2,limit=1] at @s if entity @e[tag=this,limit=1,distance=..0.003125] run tp @s ^ ^ ^4

# 到達目標位置と、一番近いブロック位置のマーカーにはthisPのタグがついていて、最も近いほうにthisをTPする
    tp @e[tag=MarkerMotion.this,limit=1] @e[tag=MarkerMotion.thisP,sort=nearest,limit=1]

# 移動させた現在位置用マーカーを戻す
    tp @e[tag=MarkerMotion.this2,limit=1] ~ ~ ~

# TP後のthisのPosを自身に代入する
    data modify entity @s Pos set from entity @e[tag=MarkerMotion.this,limit=1] Pos

# ブロック接触チェック等
    execute unless data storage neac: marker_motion.stopwith{block:0b} if score #MarkerMotion.BlockCheck neac_value matches -1 run function marker_motion:block

# スピード減少
    # constant
        execute unless score #MarkerMotion.SpeedLoss neac_value matches 0 unless data storage neac: marker_motion.speed.loss{type:"multiply"} store result storage neac: marker_motion.speed.amount int 1 run scoreboard players operation #MarkerMotion.Speed neac_value -= #MarkerMotion.SpeedLoss neac_value
    # multiply
        execute unless score #MarkerMotion.SpeedLoss neac_value matches 1000 if data storage neac: marker_motion.speed.loss{type:"multiply"} store result storage neac: marker_motion.speed.amount int 0.001 run scoreboard players operation #MarkerMotion.Speed neac_value *= #MarkerMotion.SpeedLoss neac_value

    # スピードが0未満になったら0に固定する
        execute if score #MarkerMotion.Speed neac_value matches ..-1 store result storage neac: marker_motion.speed.amount int 1 run scoreboard players set #MarkerMotion.Speed neac_value 0

# スピード0、かつ重力データが1以上なかったら停止
    execute if score #MarkerMotion.Speed neac_value matches 0 unless score #MarkerMotion.Gravity neac_value matches 1.. run tag @s add MarkerMotion.speed.0

# タグ付与
    execute if entity @s[tag=MarkerMotion.stopwith.hit] run tag @s add MarkerMotion.stop
    execute if entity @s[tag=MarkerMotion.speed.0] run tag @s add MarkerMotion.stop
    execute if entity @s[tag=MarkerMotion.on_block] run tag @s add MarkerMotion.stop

# スコアリセット
    scoreboard players reset #MarkerMotion.Pos1
    scoreboard players reset #MarkerMotion.Pos2
    scoreboard players reset #MarkerMotion.Pos3
    scoreboard players reset #MarkerMotion.Motion1
    scoreboard players reset #MarkerMotion.Motion2
    scoreboard players reset #MarkerMotion.Motion3
    scoreboard players reset #MarkerMotion.Speed
    scoreboard players reset #MarkerMotion.SpeedLoss
    scoreboard players reset #MarkerMotion.Gravity
    scoreboard players reset #MarkerMotion.GravitySum
    scoreboard players reset #MarkerMotion.BlockCheck
    scoreboard players reset #MarkerMotion.Temporary1
    scoreboard players reset #MarkerMotion.Bounce.CG.YVec.Temporary1

# ストレージデータを自身に返して初期化
    data modify entity @s data.MarkerMotion set from storage neac: marker_motion
    data remove storage neac: marker_motion
    data remove storage neac: marker_motion_pos

# 後処理
    kill @e[tag=MarkerMotion.this.All]