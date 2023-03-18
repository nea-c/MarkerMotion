#> marker_motion:tp/pos_repair
#
# ブロックに埋まってた時の修復処理
#
# @within
#   function marker_motion:tp/block
#   function marker_motion:tp/pos_repair


    execute align xyz unless predicate marker_motion:block_check/shape positioned as @s run tp @s ^ ^ ^-0.00390625

    scoreboard players remove #MarkerMotion.PosRepair neac_value 1
    execute positioned as @s align xyz unless predicate marker_motion:block_check/shape if score #MarkerMotion.PosRepair neac_value matches 1.. positioned as @s run function marker_motion:tp/pos_repair
