#> marker_motion:tp/target/
#
# ヒットしたエンティティ
#
# @within
#   function marker_motion:tp/6


# hit時停止がOFFでなければその場で停止する処理を起動
execute unless data storage neac: _.MarkerMotion.bounce.with{hit:1b} run tag @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] add MarkerMotion.stopwith.hit

tp @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] ~ ~ ~
data modify storage neac: _.tp[5][].success set value 1b

# エンティティに埋まってたら位置を修復しようとする
    scoreboard players set #MarkerMotion.PosRepair neac_value 10
    execute positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] run function marker_motion:tp/target/pos_repair
    scoreboard players reset #MarkerMotion.PosRepair

execute if data storage neac: _.MarkerMotion.bounce.with{hit:1b} run function marker_motion:tp/target/hitbox