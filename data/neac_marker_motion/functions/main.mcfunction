#> neac_marker_motion:main
#
# Markerのdata.NeAcMarkerMotion内に speed:{amount:150,loss:{amount:0.950,type:"multiply"}},gravity:392.00,bounce:{count:2,e:0.950,g:1b},stopwith:{hit:1b} のように記述
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
#
## 設定項目に関して
#   data.NeAcMarkerMotion.speed.amountのみで動作します。
#   小数値はgravity以外は第3位まで、gravityは第2位まで設定できます。
#
## 返りタグ
#   NeAcMarkerMotion.on_block : ブロックに接触した時 (跳ねた場合は付与されません)
#   NeAcMarkerMotion.on_block.wall , NeAcMarkerMotion.on_block.y , NeAcMarkerMotion.on_block.[方角] : ブロックに接触した方角やカテゴリ (NeAcMarkerMotion.on_blockがない場合は付与されません)
#   NeAcMarkerMotion.speed.0 : スピードが0になった時
#   NeAcMarkerMotion.stopwith.hit : data.stopwith.hitがtrueかつ、hitタグを付与したエンティティがいた時
#   NeAcMarkerMotion.stop : 移動処理(このfunction)が実行されないようになるタグ。NeAcMarkerMotion.on_block,NeAcMarkerMotion.stopwith.hit,NeAcMarkerMotion.speed.0のいずれかのタグがあれば必ず付与されています。
#
## 返りNBT
#   data.NeAcMarkerMotion.Motion : 移動量 (この値使って綺麗な繋がったパーティクル出したりとかできるかもしれない)
#   data.NeAcMarkerMotion.GravitySum : 重力の合計 (1秒毎にリセットとかで変な挙動できるかもしれない)
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
# @within tag/function neac_marker_motion:


#ベクトル、到達目標位置用の取得に使うマーカー
    summon marker ~ ~ ~ {Tags:["NeAcMarkerMotion.this","NeAcMarkerMotion.thisP","NeAcMarkerMotion.this.All"]}

#ベクトル取得
    execute positioned 0.0 0.0 0.0 rotated as @s run tp @e[tag=NeAcMarkerMotion.this,limit=1] ^ ^ ^1
    execute store result score #NeAcMarkerMotion.Pos1 neac_value run data get entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[0] 10000
    execute store result score #NeAcMarkerMotion.Pos2 neac_value run data get entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[1] 10000
    execute store result score #NeAcMarkerMotion.Pos3 neac_value run data get entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[2] 10000

#自身のdataから重力,スピード,重力加速度の合計とかを取得
    #重力
        execute store result score #NeAcMarkerMotion.Gravity neac_value run data get entity @s data.NeAcMarkerMotion.gravity 100
    #重力加速度
        execute store result score #NeAcMarkerMotion.GravitySum neac_value run data get entity @s data.NeAcMarkerMotion.GravitySum
    #スピード
        execute store result score #NeAcMarkerMotion.Speed neac_value run data get entity @s data.NeAcMarkerMotion.speed.amount
    #スピード減少量
        execute unless data entity @s data.NeAcMarkerMotion.speed.loss{type:"multiply"} store result score #NeAcMarkerMotion.SpeedLoss neac_value run data get entity @s data.NeAcMarkerMotion.speed.loss.amount
        execute if data entity @s data.NeAcMarkerMotion.speed.loss{type:"multiply"} if data entity @s data.NeAcMarkerMotion.speed.loss.amount store result score #NeAcMarkerMotion.SpeedLoss neac_value run data get entity @s data.NeAcMarkerMotion.speed.loss.amount 1000
    #Motionの初期化
        execute unless data entity @s data.NeAcMarkerMotion.Motion run data modify entity @s data.NeAcMarkerMotion.Motion set value [0d,0d,0d]

#X
    scoreboard players operation #NeAcMarkerMotion.Pos1 neac_value *= #NeAcMarkerMotion.Speed neac_value
    execute store result entity @s data.NeAcMarkerMotion.Motion[0] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos1 neac_value /= #100 neac_value
#Y
    scoreboard players operation #NeAcMarkerMotion.Pos2 neac_value *= #NeAcMarkerMotion.Speed neac_value
    #重力分を減算してから処理
        scoreboard players operation #NeAcMarkerMotion.GravitySum neac_value += #NeAcMarkerMotion.Gravity neac_value
        scoreboard players operation #NeAcMarkerMotion.Pos2 neac_value -= #NeAcMarkerMotion.GravitySum neac_value
        scoreboard players operation #NeAcMarkerMotion.Bounce.CG.YVec.Temporary1 neac_value = #NeAcMarkerMotion.Pos2 neac_value
    execute store result entity @s data.NeAcMarkerMotion.Motion[1] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos2 neac_value /= #100 neac_value
    #重力加速度をnbtに格納
        execute store result entity @s data.NeAcMarkerMotion.GravitySum int 1 run scoreboard players get #NeAcMarkerMotion.GravitySum neac_value

#Z
    scoreboard players operation #NeAcMarkerMotion.Pos3 neac_value *= #NeAcMarkerMotion.Speed neac_value
    execute store result entity @s data.NeAcMarkerMotion.Motion[2] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos3 neac_value /= #100 neac_value

#現在位置とモーションの数値を取得して計算
    #現在位置
        execute store result score #NeAcMarkerMotion.Pos1 neac_value run data get entity @s Pos[0] 10000
        execute store result score #NeAcMarkerMotion.Pos2 neac_value run data get entity @s Pos[1] 10000
        execute store result score #NeAcMarkerMotion.Pos3 neac_value run data get entity @s Pos[2] 10000
    #モーション値
        execute store result score #NeAcMarkerMotion.Motion1 neac_value run data get entity @s data.NeAcMarkerMotion.Motion[0] 10000
        execute store result score #NeAcMarkerMotion.Motion2 neac_value run data get entity @s data.NeAcMarkerMotion.Motion[1] 10000
        execute store result score #NeAcMarkerMotion.Motion3 neac_value run data get entity @s data.NeAcMarkerMotion.Motion[2] 10000

#到達目標位置にベクトル取得時に使ったマーカーを使いまわして配置
    #その際離れているとPosが代入できないっぽいので一度実行位置にTP
        tp @e[tag=NeAcMarkerMotion.this,limit=1] ~ ~ ~

    #計算&代入
        execute store result entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[0] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos1 neac_value += #NeAcMarkerMotion.Motion1 neac_value
        execute store result entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[1] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos2 neac_value += #NeAcMarkerMotion.Motion2 neac_value
        execute store result entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[2] double 0.0001 run scoreboard players operation #NeAcMarkerMotion.Pos3 neac_value += #NeAcMarkerMotion.Motion3 neac_value

#現在位置と到達目標位置の間にブロックがあるかチェック
    #現在位置用のマーカー召喚
        summon marker ~ ~ ~ {Tags:["NeAcMarkerMotion.this2","NeAcMarkerMotion.thisP","NeAcMarkerMotion.this.All"]}
    #現在位置用マーカーを到達目標位置に向ける
        execute as @e[tag=NeAcMarkerMotion.this2,limit=1] at @s facing entity @e[tag=NeAcMarkerMotion.this,sort=furthest,limit=1] feet run tp @s ~ ~ ~ ~ ~
    #function再起で到達目標位置までの間にブロックがあるかチェック
    #その際targetタグがいればヒット判定を返す　また、speed.hitstopがtrueであればNeAcMarkerMotion.stopwith.hitを返す
        tag @s add NeAcMarkerMotion.me
        #hit時にそこで停止する処理用に一時的にスコア設定
            execute store result score #NeAcMarkerMotion.Temporary1 neac_value run data get entity @s data.NeAcMarkerMotion.stopwith.hit
        execute as @e[tag=NeAcMarkerMotion.this2,limit=1] run function neac_marker_motion:tp
        tag @s remove NeAcMarkerMotion.me
        #現在位置と到達目標位置の距離が限りなく近い場合は間にブロックがなかったことにして、下のnearestTPの判定にならないように遠ざける
            execute as @e[tag=NeAcMarkerMotion.this2,limit=1] at @s if entity @e[tag=this,limit=1,distance=..0.003125] run tp @s ^ ^ ^4

#到達目標位置と、一番近いブロック位置のマーカーにはthisPのタグがついていて、最も近いほうにthisをTPする
    tp @e[tag=NeAcMarkerMotion.this,limit=1] @e[tag=NeAcMarkerMotion.thisP,sort=nearest,limit=1]

#移動させた現在位置用マーカーを戻す
    tp @e[tag=NeAcMarkerMotion.this2,limit=1] ~ ~ ~

#TP後のthisのPosを自身に代入する
    data modify entity @s Pos set from entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos

#Pos代入によるズレで自身がブロックに埋まっていたら後ろに少し下がる
    execute at @s align xyz unless block ~ ~ ~ #neac_marker_motion:no_collision at @s rotated as @e[tag=NeAcMarkerMotion.this2,limit=1] run tp @s ^ ^ ^-0.01

#ブロック接触チェック
    #east
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~0.01 ~ ~ #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 1
    #west
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~-0.01 ~ ~ #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 2
    #up
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~0.01 ~ #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 3
    #down
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~-0.01 ~ #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 4
    #south
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~ ~0.01 #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 5
    #north
        execute unless score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~ ~-0.01 #neac_marker_motion:no_collision run scoreboard players set #NeAcMarkerMotion.BlockCheck neac_value 6
    
    #接触してたらいろいろするやつ
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1 at @s align x run tp @s ~0.98 ~ ~
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 2 at @s align x run tp @s ~0.02 ~ ~
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3 at @s align y run tp @s ~ ~0.98 ~
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 4 at @s align y run tp @s ~ ~0.02 ~
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 5 at @s align z run tp @s ~ ~ ~0.98
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 6 at @s align z run tp @s ~ ~ ~0.02

        #ここが動いたら以降の処理(タグつけたりが動かなくなる仕様)
            #1瞬だけつくようにBounce検知用タグの削除。付与は neac_marker_motion:bounce
                execute if entity @s[tag=NeAcMarkerMotion.bounce] run tag @s remove NeAcMarkerMotion.bounce
            execute store result score #NeAcMarkerMotion.Temporary1 neac_value run data get entity @s data.NeAcMarkerMotion.bounce.count
            execute if score #NeAcMarkerMotion.Temporary1 neac_value matches -1 run scoreboard players set #NeAcMarkerMotion.Temporary1 neac_value 1
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. if score #NeAcMarkerMotion.Temporary1 neac_value matches 1.. run function neac_marker_motion:bounce/

        #接触してたらon_blockタグ付与
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. run tag @s add NeAcMarkerMotion.on_block
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3..4 run tag @s add NeAcMarkerMotion.on_block.y
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1.. unless score #NeAcMarkerMotion.BlockCheck neac_value matches 3..4 run tag @s add NeAcMarkerMotion.on_block.wall

        #接触方向に対して固定位置に移動
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 1 run tag @s add NeAcMarkerMotion.on_block.east
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 2 run tag @s add NeAcMarkerMotion.on_block.west
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3 run tag @s add NeAcMarkerMotion.on_block.up
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 4 run tag @s add NeAcMarkerMotion.on_block.down
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 5 run tag @s add NeAcMarkerMotion.on_block.south
            execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 6 run tag @s add NeAcMarkerMotion.on_block.north

#スピード減少
    #constant
        execute if score #NeAcMarkerMotion.SpeedLoss neac_value matches 1.. unless data entity @s data.NeAcMarkerMotion.speed.loss{type:"multiply"} store result entity @s data.NeAcMarkerMotion.speed.amount int 0.001 run scoreboard players operation #NeAcMarkerMotion.Speed neac_value -= #NeAcMarkerMotion.SpeedLoss neac_value
    #multiply
        execute if score #NeAcMarkerMotion.SpeedLoss neac_value matches 0..999 if data entity @s data.NeAcMarkerMotion.speed.loss{type:"multiply"} store result entity @s data.NeAcMarkerMotion.speed.amount int 0.001 run scoreboard players operation #NeAcMarkerMotion.Speed neac_value *= #NeAcMarkerMotion.SpeedLoss neac_value
    
    execute if score #NeAcMarkerMotion.Speed neac_value matches ..0 unless data entity @s data.NeAcMarkerMotion.bounce{g:1b} run tag @s add NeAcMarkerMotion.speed.0

#タグ付与
    execute if entity @s[tag=NeAcMarkerMotion.stopwith.hit] run tag @s add NeAcMarkerMotion.stop
    execute if entity @s[tag=NeAcMarkerMotion.speed.0] run tag @s add NeAcMarkerMotion.stop
    execute if entity @s[tag=NeAcMarkerMotion.on_block] run tag @s add NeAcMarkerMotion.stop

#スコアリセット
    scoreboard players reset #NeAcMarkerMotion.Pos1
    scoreboard players reset #NeAcMarkerMotion.Pos2
    scoreboard players reset #NeAcMarkerMotion.Pos3
    scoreboard players reset #NeAcMarkerMotion.Motion1
    scoreboard players reset #NeAcMarkerMotion.Motion2
    scoreboard players reset #NeAcMarkerMotion.Motion3
    scoreboard players reset #NeAcMarkerMotion.Speed
    scoreboard players reset #NeAcMarkerMotion.SpeedLoss
    scoreboard players reset #NeAcMarkerMotion.Gravity
    scoreboard players reset #NeAcMarkerMotion.GravitySum
    scoreboard players reset #NeAcMarkerMotion.BlockCheck
    scoreboard players reset #NeAcMarkerMotion.Temporary1
    scoreboard players reset #NeAcMarkerMotion.Bounce.CG.YVec.Temporary1

#後処理
    kill @e[tag=NeAcMarkerMotion.this.All]