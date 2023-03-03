#> marker_motion:tp/targets
#
# ヒットしたエンティティ
#
# @within
#   function marker_motion:tp/0016


# hitタグ付与
tag @e[tag=targets] add MarkerMotion.hit

# hit時停止がONであればその場で停止する処理を起動
execute if data storage neac: _.MarkerMotion.stopwith{hit:1b} if entity @e[tag=MarkerMotion.hit,limit=1] run tag @s add MarkerMotion.stopwith.hit
execute if data storage neac: _.MarkerMotion.stopwith{hit:1b} if entity @e[tag=MarkerMotion.hit,limit=1] run tp @s ~ ~ ~
execute if data storage neac: _.MarkerMotion.stopwith{hit:1b} if entity @e[tag=MarkerMotion.hit,limit=1] run scoreboard players set #expl:003125 neac_value 1
