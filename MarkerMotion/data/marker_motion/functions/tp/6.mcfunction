#> marker_motion:tp/6
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:tp/5


# 初期化
data modify storage neac: _.tp[5][].success set value 2b

# エンティティ探査
execute if entity @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.target,x=0,limit=1] positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.target,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] run tag @s add MarkerMotion.hit
execute unless data storage neac: _.MarkerMotion.stopwith{hit:0b} if entity @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,limit=1] run function marker_motion:tp/target/

# ブロック扱いエンティティ探索
execute if data storage neac: _.tp[5][{success:2b}] unless data storage neac: _.MarkerMotion.stopwith{block:0b} if entity @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.as_block,x=0,limit=1] positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.as_block,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] run tag @s add MarkerMotion.hitAsBlock
execute if data storage neac: _.tp[5][{success:2b}] unless data storage neac: _.MarkerMotion.stopwith{block:0b} if entity @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hitAsBlock,x=0,limit=1] run function marker_motion:tp/as_block/

# 到達点探査
execute if data storage neac: _.tp[5][{success:2b}] if entity @s[distance=..0.015625] positioned as @s positioned ^ ^ ^0.0000152587890625 store success storage neac: _.tp[5][].success byte 1 run tp @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] ~ ~ ~

# ブロック探査
execute if data storage neac: _.tp[5][{success:2b}] if data storage neac: _.MarkerMotion.stopwith{block:0b} run data modify storage neac: _.tp[5][].success set value 0b

execute if data storage neac: _.tp[5][{success:2b}] positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated ~180 ~ positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated ~180 ~ positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated as @s positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated as @s positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated as @s rotated ~180 ~ positioned ^ ^ ^0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point
execute if data storage neac: _.tp[5][{success:2b}] rotated as @s rotated ~180 ~ positioned ^ ^ ^-0.015625 if predicate marker_motion:block_check/condition rotated as @s run function marker_motion:tp/block/point

# 探査の停止
execute if data storage neac: _.tp[5][{success:1b}] store result storage neac: _.tp[][].success byte 1 run scoreboard players set #MarkerMotion.loop neac_value 0
