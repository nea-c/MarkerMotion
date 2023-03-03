#> marker_motion:tp/0256
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/0512

## エンティティ探査
# 立方体のdx,dy,dzによる探査範囲を置いてエンティティをチェック
data modify storage neac: _.0256 set value 0b
execute positioned ~-0.128 ~-0.128 ~-0.128 as @e[tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~-0.768 ~-0.768 ~-0.768 if entity @s[dx=0,dy=0,dz=0] run data modify storage neac: _.0256 set value 1b

## 到達点探査
execute if entity @e[tag=MarkerMotion.this,distance=..0.128,limit=1] run data modify storage neac: _.0256 set value 1b

## ブロック探査
# 角8方向に探査点を伸ばしてチェック
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.128 ~-0.128 ~-0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.128 ~-0.128 ~0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.128 ~-0.128 ~-0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.128 ~-0.128 ~0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.128 ~0.128 ~-0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~-0.128 ~0.128 ~0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.128 ~0.128 ~-0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} unless block ~0.128 ~0.128 ~0.128 #marker_motion:no_collision run data modify storage neac: _.0256 set value 1b

# ブロックかエンティティがあったらさらに細かくチェック
execute if data storage neac: _{0256:1b} positioned ^ ^ ^-0.064 run function marker_motion:tp/0128
execute if data storage neac: _{0256:1b} positioned ^ ^ ^0.064 run function marker_motion:tp/0128