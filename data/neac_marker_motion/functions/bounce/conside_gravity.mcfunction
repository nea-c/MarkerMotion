
#次tickの飛行方向のYベクトル取得
    execute positioned 0.0 0.0 0.0 rotated as @s run tp @e[tag=NeAcMarkerMotion.this,limit=1] ^ ^ ^1
    execute store result score #NeAcMarkerMotion.Bounce.CG.YVec neac_value run data get entity @e[tag=NeAcMarkerMotion.this,limit=1] Pos[1] 10000
    scoreboard players operation #NeAcMarkerMotion.Bounce.CG.YVec neac_value *= #NeAcMarkerMotion.Speed neac_value

#今のYベクトル(重力)を取得して次tickのベクトルを引く
    scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value = #NeAcMarkerMotion.Bounce.CG.YVec neac_value
    #ブロック下面
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 3 if score #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value matches 1.. run scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value *= #-1 neac_value
    #ブロック上面
        execute if score #NeAcMarkerMotion.BlockCheck neac_value matches 4 if score #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value matches ..-1 run scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value *= #-1 neac_value

    #今のYベクトル(#NeAcMarkerMotion.Bounce.CG.YVec.Temporary1 neac_value)を退避
        scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary1 neac_value = #NeAcMarkerMotion.Bounce.CG.YVec.Temporary1 neac_value
    #退避スコアを使って計算
        scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary1 neac_value += #NeAcMarkerMotion.Bounce.CG.Temporary2 neac_value

        #前ブロックに跳ねたときのYベクトルの記憶を呼ぶ
            execute if data entity @s data.NeAcMarkerMotion.GravitySumTemp store result score #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value run data get entity @s data.GravitySumTemp 0.00988
            #同じ数値を持つスコアを作る
                execute if data entity @s data.NeAcMarkerMotion.GravitySumTemp store result score #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value run scoreboard players operation #NeAcMarkerMotion.Bounce.CG.YVec.Before.copy neac_value = #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value
            #上で作った同じスコアのやつと自身で同じ量の正負の誤差をつける
                execute if data entity @s data.NeAcMarkerMotion.GravitySumTemp store result score #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value run scoreboard players add #NeAcMarkerMotion.Bounce.CG.YVec.Before.copy neac_value 125
                execute if data entity @s data.NeAcMarkerMotion.GravitySumTemp store result score #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value run scoreboard players remove #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value 125
        #data.NeAcMarkerMotion.bounce.eが1のとき値を直接入れる
            execute unless score #NeAcMarkerMotion.Bounce.e neac_value matches 1000 store result entity @s data.NeAcMarkerMotion.GravitySum int 1 run scoreboard players get #NeAcMarkerMotion.Bounce.CG.Temporary1 neac_value
        #data.NeAcMarkerMotion.bounce.eが1以外の場合は計算して代入する
            execute if score #NeAcMarkerMotion.Bounce.e neac_value matches 0..999 store result entity @s data.NeAcMarkerMotion.GravitySum int 0.001 run scoreboard players operation #NeAcMarkerMotion.Bounce.CG.Temporary1 neac_value *= #NeAcMarkerMotion.Bounce.e neac_value

        #data.NeAcMarkerMotion.GravitySumをdata.GravitySumTempに保存
            data modify entity @s data.NeAcMarkerMotion.GravitySumTemp set from entity @s data.NeAcMarkerMotion.GravitySum
        #保存したdata.NeAcMarkerMotion.GravitySumTempを取得
            execute store result score #NeAcMarkerMotion.Bounce.CG.GravitySum neac_value run data get entity @s data.NeAcMarkerMotion.GravitySumTemp 0.00988
            #取得した値と誤差を作ったスコアで比較し、前回跳ねたときと誤差が少なければ止まったとみなす
            execute if score #NeAcMarkerMotion.Speed neac_value matches ..0 if score #NeAcMarkerMotion.Bounce.CG.YVec.Before neac_value <= #NeAcMarkerMotion.Bounce.CG.GravitySum neac_value if score #NeAcMarkerMotion.Bounce.CG.GravitySum neac_value <= #NeAcMarkerMotion.Bounce.CG.YVec.Before.copy neac_value at @s run tag @s add NeAcMarkerMotion.speed.0.bounce

#タグをつける
    execute if entity @s[tag=NeAcMarkerMotion.speed.0.bounce] run tag @s add NeAcMarkerMotion.speed.0

scoreboard players reset #NeAcMarkerMotion.Bounce.CG.YVec
scoreboard players reset #NeAcMarkerMotion.Bounce.CG.YVec.Before
scoreboard players reset #NeAcMarkerMotion.Bounce.CG.YVec.Before.copy
scoreboard players reset #NeAcMarkerMotion.Bounce.CG.GravitySum
scoreboard players reset #NeAcMarkerMotion.Bounce.CG.Temporary2