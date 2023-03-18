#> marker_motion:tp/targets
#
# ヒットしたエンティティ
#
# @within
#   function marker_motion:tp/0016


# hitタグ付与
tag @e[tag=targets] add MarkerMotion.hit
# タグ削除
tag @e[tag=targets] remove targets

# hit時停止がOFFでなければその場で停止する処理を起動
execute unless data storage neac: _.MarkerMotion.stopwith{hit:0b} if entity @e[tag=MarkerMotion.hit,limit=1] run tag @s add MarkerMotion.stopwith.hit
execute unless data storage neac: _.MarkerMotion.stopwith{hit:0b} if entity @e[tag=MarkerMotion.hit,limit=1] run tp @s ~ ~ ~
execute unless data storage neac: _.MarkerMotion.stopwith{hit:0b} if entity @e[tag=MarkerMotion.hit,limit=1] run data modify storage neac: _.tp[5][].success set value 1b
execute unless data storage neac: _.MarkerMotion.stopwith{hit:0b} if entity @e[tag=MarkerMotion.hit,limit=1] run data modify storage neac: _.tp[6][].success set value 1b
