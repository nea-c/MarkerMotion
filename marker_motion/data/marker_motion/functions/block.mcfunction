#> marker_motion:block
#
# ブロック接触チェックとか
#
# @within
#   function marker_motion:main
#   function marker_motion:block

# Pos代入によるズレで自身がブロックに埋まっていたら後ろに少し下がる
    execute at @s align xyz unless block ~ ~ ~ #marker_motion:no_collision at @s rotated as @e[tag=MarkerMotion.this2,limit=1] run tp @s ^ ^ ^-0.01

# ブロック接触チェック
    # east
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~0.01 ~ ~ #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 1
    # west
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~-0.01 ~ ~ #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 2
    # up
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~0.01 ~ #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 3
    # down
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~-0.01 ~ #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 4
    # south
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~ ~0.01 #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 5
    # north
        execute unless score #MarkerMotion.BlockCheck neac_value matches 1.. at @s unless block ~ ~ ~-0.01 #marker_motion:no_collision run scoreboard players set #MarkerMotion.BlockCheck neac_value 6

    # 接触検知したらいろいろするやつ
        execute if score #MarkerMotion.BlockCheck neac_value matches 1 at @s align x run tp @s ~0.98 ~ ~
        execute if score #MarkerMotion.BlockCheck neac_value matches 2 at @s align x run tp @s ~0.02 ~ ~
        execute if score #MarkerMotion.BlockCheck neac_value matches 3 at @s align y run tp @s ~ ~0.98 ~
        execute if score #MarkerMotion.BlockCheck neac_value matches 4 at @s align y run tp @s ~ ~0.02 ~
        execute if score #MarkerMotion.BlockCheck neac_value matches 5 at @s align z run tp @s ~ ~ ~0.98
        execute if score #MarkerMotion.BlockCheck neac_value matches 6 at @s align z run tp @s ~ ~ ~0.02

        # ここが動いたら以降の処理(タグつけたりが動かなくなる仕様)
            # 1瞬だけつくようにBounce検知用タグの削除。付与は marker_motion:bounce
                execute if entity @s[tag=MarkerMotion.bounce] run tag @s remove MarkerMotion.bounce
            execute store result score #MarkerMotion.Temporary1 neac_value run data get storage neac: marker_motion.bounce.count
            execute if score #MarkerMotion.Temporary1 neac_value matches -1 run scoreboard players set #MarkerMotion.Temporary1 neac_value 1
            execute if score #MarkerMotion.BlockCheck neac_value matches 1.. if score #MarkerMotion.Temporary1 neac_value matches 1.. run function marker_motion:bounce/

        # 接触してたらon_blockタグ付与
            execute if score #MarkerMotion.BlockCheck neac_value matches 1.. run tag @s add MarkerMotion.on_block
            execute if score #MarkerMotion.BlockCheck neac_value matches 3..4 run tag @s add MarkerMotion.on_block.y
            execute if score #MarkerMotion.BlockCheck neac_value matches 1.. unless score #MarkerMotion.BlockCheck neac_value matches 3..4 run tag @s add MarkerMotion.on_block.wall

        # 接触方向に対して固定位置に移動
            execute if score #MarkerMotion.BlockCheck neac_value matches 1 run tag @s add MarkerMotion.on_block.east
            execute if score #MarkerMotion.BlockCheck neac_value matches 2 run tag @s add MarkerMotion.on_block.west
            execute if score #MarkerMotion.BlockCheck neac_value matches 3 run tag @s add MarkerMotion.on_block.up
            execute if score #MarkerMotion.BlockCheck neac_value matches 4 run tag @s add MarkerMotion.on_block.down
            execute if score #MarkerMotion.BlockCheck neac_value matches 5 run tag @s add MarkerMotion.on_block.south
            execute if score #MarkerMotion.BlockCheck neac_value matches 6 run tag @s add MarkerMotion.on_block.north