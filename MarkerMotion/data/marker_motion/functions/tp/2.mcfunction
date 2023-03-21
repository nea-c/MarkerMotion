#> marker_motion:tp/2
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/1


# 初期化
data modify storage neac: _.tp[1][].success set value 1b

# ブロック探査
execute if data storage neac: _.MarkerMotion.stopwith{block:0b} run data modify storage neac: _.tp[1][].success set value 0b
execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} if block ^ ^ ^0.25 #marker_motion:no_collision if block ^ ^ ^-0.25 #marker_motion:no_collision rotated ~180 ~ if block ^ ^ ^0.25 #marker_motion:no_collision if block ^ ^ ^-0.25 #marker_motion:no_collision rotated as @s if block ^ ^ ^0.25 #marker_motion:no_collision if block ^ ^ ^-0.25 #marker_motion:no_collision rotated ~180 ~ if block ^ ^ ^0.25 #marker_motion:no_collision if block ^ ^ ^-0.25 #marker_motion:no_collision if predicate marker_motion:block_check/shape/erosion/check run data modify storage neac: _.tp[1][].success set value 0b

# エンティティ探査
execute if entity @e[tag=MarkerMotion.target,limit=1] positioned ~-0.25 ~-0.25 ~-0.25 as @e[tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~-0.5 ~-0.5 ~-0.5 if entity @s[dx=0,dy=0,dz=0] run data modify storage neac: _.tp[1][].success set value 1b

# 到達点探査
execute if entity @s[distance=..0.25] run data modify storage neac: _.tp[1][].success set value 1b


# 上で満たしたらさらに細かくチェック
execute if data storage neac: _.tp[1][{success:1b}] positioned ^ ^ ^-0.125 run function marker_motion:tp/3
execute if data storage neac: _.tp[1][{success:1b}] positioned ^ ^ ^0.125 run function marker_motion:tp/3