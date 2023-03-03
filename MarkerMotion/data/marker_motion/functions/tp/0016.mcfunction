#> marker_motion:tp/0016
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/0032

## エンティティ探査
# 立方体のdx,dy,dzによる探査範囲を置いてエンティティをチェック
execute positioned ~-0.008 ~-0.008 ~-0.008 as @e[tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~-1.008 ~-1.008 ~-1.008 if entity @s[dx=0,dy=0,dz=0] run tag @s add targets
execute if entity @e[tag=targets] positioned ~-0.008 ~-0.008 ~-0.008 run function marker_motion:tp/targets

## 到達点探査
execute unless score #MarkerMotion.tpCheck neac_value matches 1 run scoreboard players set #MarkerMotion.tpCheck neac_value 0
execute unless score #MarkerMotion.tpCheck neac_value matches 1 if entity @e[tag=MarkerMotion.this,distance=..0.008,limit=1] positioned as @e[tag=MarkerMotion.this,distance=..0.008,limit=1] store success score #MarkerMotion.tpCheck neac_value run tp @s ~ ~ ~
scoreboard players remove #MarkerMotion.tpCheck neac_value 2

## ブロック探査
# 角8方向に探査点を伸ばしてチェック
# エンティティがいない場合、ブロックがある場所で探査終了
# ブロック貫通がONだったらそもそも処理しない
execute if score #MarkerMotion.tpCheck neac_value matches -2 if data storage neac: _.MarkerMotion.stopwith{block:0b} run scoreboard players set #MarkerMotion.tpCheck neac_value -3
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~-0.008 ~-0.008 ~-0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~-0.008 ~-0.008 ~0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~0.008 ~-0.008 ~-0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~0.008 ~-0.008 ~0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~-0.008 ~0.008 ~-0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~-0.008 ~0.008 ~0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~0.008 ~0.008 ~-0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point
execute if score #MarkerMotion.tpCheck neac_value matches -2 unless block ~0.008 ~0.008 ~0.008 #marker_motion:no_collision store success score #MarkerMotion.tpCheck neac_value run function marker_motion:tp/point

## 後処理
# タグ削除
tag @e[tag=targets] remove targets
# 探査の停止
execute if score #MarkerMotion.tpCheck neac_value matches -1..1 store result storage neac: _.1024 byte 1 store result storage neac: _.0512 byte 1 store result storage neac: _.0256 byte 1 store result storage neac: _.0128 byte 1 store result storage neac: _.0064 byte 1 store result storage neac: _.0032 byte 1 run scoreboard players set #MarkerMotion.loop neac_value 0

scoreboard players reset #MarkerMotion.tpCheck