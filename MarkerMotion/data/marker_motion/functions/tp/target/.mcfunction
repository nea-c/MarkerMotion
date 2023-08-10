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

execute if data storage neac: _.MarkerMotion.bounce.with{hit:1b} run function marker_motion:tp/target/hitbox