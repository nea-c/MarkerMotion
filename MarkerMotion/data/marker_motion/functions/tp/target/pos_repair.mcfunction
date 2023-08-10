#> marker_motion:tp/target/pos_repair
#
# ブロックに埋まってた時の修復処理
#
# @within
#   function marker_motion:tp/target/
#   function marker_motion:tp/target/pos_repair

    execute positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] run tp @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] ^ ^ ^-0.00390625

    scoreboard players remove #MarkerMotion.PosRepair neac_value 1
    execute positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] if score #MarkerMotion.PosRepair neac_value matches 1.. positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] run function marker_motion:tp/target/pos_repair
