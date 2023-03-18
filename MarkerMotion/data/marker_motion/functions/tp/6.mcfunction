#> marker_motion:tp/6
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/5


# 初期化
data modify storage neac: _.tp[5][].success set value 0b
data modify storage neac: _.tp[6][].success set value 0b

# エンティティ探査
execute if entity @e[tag=MarkerMotion.target,limit=1] positioned ~-0.015625 ~-0.015625 ~-0.015625 as @e[tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~-0.96875 ~-0.96875 ~-0.96875 if entity @s[dx=0,dy=0,dz=0] run tag @s add targets
execute if entity @e[tag=targets,limit=1] positioned ~-0.015625 ~-0.015625 ~-0.015625 run function marker_motion:tp/targets

# 到達点探査
execute if data storage neac: _.tp[5][{success:0b}] if entity @e[type=#marker_motion:selector,tag=MarkerMotion.this,distance=..0.015625,limit=1] positioned ^ ^ ^0.0000152587890625 store success storage neac: _.tp[6][].success byte 1 run tp @s ~ ~ ~

# ブロック探査
execute if data storage neac: _.tp[6][{success:0b}] if data storage neac: _.MarkerMotion.stopwith{block:0b} run data modify storage neac: _.tp[6][].success set value 2b

execute if data storage neac: _.tp[6][{success:0b}] positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated ~180 ~ positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated ~180 ~ positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated as @e[type=#marker_motion:selector,tag=MarkerMotion.this,limit=1] positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated as @e[type=#marker_motion:selector,tag=MarkerMotion.this,limit=1] positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated as @e[type=#marker_motion:selector,tag=MarkerMotion.this,limit=1] rotated ~180 ~ positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point
execute if data storage neac: _.tp[6][{success:0b}] rotated as @e[type=#marker_motion:selector,tag=MarkerMotion.this,limit=1] rotated ~180 ~ positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/point

data modify storage neac: _.tpCheck append from storage neac: _.tp[5][]
data modify storage neac: _.tpCheck append from storage neac: _.tp[6][]

# 探査の停止
execute if data storage neac: _.tpCheck[{success:1b}] store result storage neac: _.tp[][].success byte 1 run scoreboard players set #MarkerMotion.loop neac_value 0
