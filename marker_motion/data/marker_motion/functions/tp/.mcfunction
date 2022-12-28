#> marker_motion:tp/
#
# 移動先目標までの間にブロックがあるか探す処理
# その際にヒットボックスでのヒットを行ったりできる
#
# @within
#   function marker_motion:main
#   function marker_motion:tp/

# ブロックに接触したら止まるかで処理分岐
    execute unless data storage neac: marker_motion.stopwith{block:0b} run function marker_motion:tp/default
    execute if data storage neac: marker_motion.stopwith{block:0b} run function marker_motion:tp/block_perforate

# ここで blockedタグがついていればブロックに接触したことになるので-1にする
    execute if entity @s[tag=MarkerMotion.tp.blocked] unless data storage neac: marker_motion.stopwith{block:0b} run scoreboard players set #MarkerMotion.BlockCheck neac_value -1

# targetタグがついたエンティティがいればヒットボックス判定でそのタグにhitタグをつける
    execute if entity @e[tag=MarkerMotion.target,limit=1] at @s positioned ~-0.5 ~-0.5 ~-0.5 as @e[dx=0,tag=MarkerMotion.target] run tag @s add MarkerMotion.hit
    # スペクテイターは除外
        execute as @a[tag=MarkerMotion.hit,gamemode=spectator] run tag @s remove MarkerMotion.hit
# hitしたエンティティがいて、かつヒットしたら停止する条件がオンの時、停止用タグをつけてループ処理を離脱できるように
    execute if data storage neac: marker_motion.stopwith{hit:1b} if entity @e[tag=MarkerMotion.hit,limit=1] run tag @e[tag=MarkerMotion.me,limit=1] add MarkerMotion.stopwith.hit
    execute if data storage neac: marker_motion.stopwith{hit:1b} if entity @e[tag=MarkerMotion.hit,limit=1] run tag @s add MarkerMotion.tp.blocked

# カウンター加算。一定回数以上再起しないように
    scoreboard players add @s neac_value 1
    execute if entity @s[tag=!MarkerMotion.tp.blocked] unless score @s neac_value matches 35.. at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.003125] run function marker_motion:tp/
