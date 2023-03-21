#> marker_motion:tp/targets
#
# ヒットしたエンティティ
#
# @within
#   function marker_motion:tp/0016


# hit時停止がOFFでなければその場で停止する処理を起動
tag @e[type=marker,tag=MarkerMotion.me,limit=1] add MarkerMotion.stopwith.hit
tp @e[type=marker,tag=MarkerMotion.me,limit=1] ~ ~ ~
data modify storage neac: _.tp[5][].success set value 1b
