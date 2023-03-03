#> marker_motion:tp/1024
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/
#   function marker_motion:tp/1024


## エンティティ探査
# 立方体のdx,dy,dzによる探査範囲を置いてエンティティをチェック
data modify storage neac: _.1024 set value 0b
execute positioned ~-0.512 ~-0.512 ~-0.512 if entity @e[tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~0.512 ~0.512 ~0.512 run data modify storage neac: _.1024 set value 1b

## 到達点探査
execute if entity @e[tag=MarkerMotion.this,distance=..0.512,limit=1] run data modify storage neac: _.1024 set value 1b

## ブロック探査
# 角8方向に探査点を伸ばしてチェック
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.512 ~-0.512 ~-0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.512 ~-0.512 ~0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.512 ~-0.512 ~-0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.512 ~-0.512 ~0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.512 ~0.512 ~-0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.512 ~0.512 ~0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.512 ~0.512 ~-0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.512 ~0.512 ~0.512 #marker_motion:no_collision run data modify storage neac: _.1024 set value 1b

# ブロックがあったらさらに細かくチェック
execute if data storage neac: _{1024:1b} positioned ^ ^ ^-0.256 run function marker_motion:tp/0512
execute if data storage neac: _{1024:1b} positioned ^ ^ ^0.256 run function marker_motion:tp/0512

## ループ
# ブロックがなかったら1m先に進む
scoreboard players remove #MarkerMotion.loop neac_value 1
execute if score #MarkerMotion.loop neac_value matches 1.. positioned ^ ^ ^1.024 run function marker_motion:tp/1024