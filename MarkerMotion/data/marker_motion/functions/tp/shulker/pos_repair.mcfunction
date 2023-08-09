#> marker_motion:tp/shulker/pos_repair
#
# ブロックに埋まってた時の修復処理
#
# @within
#   function marker_motion:tp/shulker/
#   function marker_motion:tp/shulker/pos_repair

    execute positioned as @e[type=shulker,tag=MarkerMotion.hitShulker,distance=..5,limit=1] if predicate marker_motion:shulker positioned as @s run tp @s ^ ^ ^-0.00390625

    scoreboard players remove #MarkerMotion.PosRepair neac_value 1
    execute positioned as @e[type=shulker,tag=MarkerMotion.hitShulker,distance=..5,limit=1] if predicate marker_motion:shulker if score #MarkerMotion.PosRepair neac_value matches 1.. run function marker_motion:tp/shulker/pos_repair
