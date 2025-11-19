#> marker_motion:tp/target/hitbox
#
# ヒットエンティティ探索
#
# @within
#   function marker_motion:tp/target/


# エンティティに埋まってたら位置を修復しようとする
    scoreboard players set #MarkerMotion.PosRepair neac_value 10
    execute positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0] positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] run function marker_motion:tp/target/pos_repair
    scoreboard players reset #MarkerMotion.PosRepair

## エンティティ接触チェック
    # ストレージ初期化
        data modify storage neac: _.block set value {ok:0b,down:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],up:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],south:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],north:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],east:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],west:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}]}

    # 8点をチェックしてストレージにデータを入れる
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~-0.0078125 ~-0.0078125 store success storage neac: _.block.down[4].success byte 1 store success storage neac: _.block.north[2].success byte 1 store success storage neac: _.block.west[2].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~-0.0078125 ~0.0078125 store success storage neac: _.block.down[3].success byte 1 store success storage neac: _.block.south[2].success byte 1 store success storage neac: _.block.west[1].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~-0.0078125 ~-0.0078125 store success storage neac: _.block.down[2].success byte 1 store success storage neac: _.block.north[1].success byte 1 store success storage neac: _.block.east[2].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~-0.0078125 ~0.0078125 store success storage neac: _.block.down[1].success byte 1 store success storage neac: _.block.south[1].success byte 1 store success storage neac: _.block.east[1].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~0.0078125 ~-0.0078125 store success storage neac: _.block.up[4].success byte 1 store success storage neac: _.block.north[4].success byte 1 store success storage neac: _.block.west[4].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~0.0078125 ~0.0078125 store success storage neac: _.block.up[3].success byte 1 store success storage neac: _.block.south[4].success byte 1 store success storage neac: _.block.west[3].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~0.0078125 ~-0.0078125 store success storage neac: _.block.up[2].success byte 1 store success storage neac: _.block.north[3].success byte 1 store success storage neac: _.block.east[4].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~0.0078125 ~0.0078125 store success storage neac: _.block.up[1].success byte 1 store success storage neac: _.block.south[3].success byte 1 store success storage neac: _.block.east[3].success byte 1 positioned ~-0.000030517578125 ~-0.000030517578125 ~-0.000030517578125 as @e[type=!#marker_motion:hasnt_hitbox,tag=MarkerMotion.hit,dx=0,dy=0,dz=0] positioned ~-0.999969482421875 ~-0.999969482421875 ~-0.999969482421875 if entity @s[dx=0,dy=0,dz=0]

    # 接触判定が行われた最大値を取得
        scoreboard players set #MarkerMotion.BlockCheck neac_value 0
        data remove storage neac: _.block.down[{success:0b}]
        execute store result score #MarkerMotion.down neac_value run data get storage neac: _.block.down
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.down neac_value

        data remove storage neac: _.block.up[{success:0b}]
        execute store result score #MarkerMotion.up neac_value run data get storage neac: _.block.up
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.up neac_value

        data remove storage neac: _.block.east[{success:0b}]
        execute store result score #MarkerMotion.east neac_value run data get storage neac: _.block.east
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.east neac_value

        data remove storage neac: _.block.west[{success:0b}]
        execute store result score #MarkerMotion.west neac_value run data get storage neac: _.block.west
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.west neac_value

        data remove storage neac: _.block.south[{success:0b}]
        execute store result score #MarkerMotion.south neac_value run data get storage neac: _.block.south
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.south neac_value

        data remove storage neac: _.block.north[{success:0b}]
        execute store result score #MarkerMotion.north neac_value run data get storage neac: _.block.north
        scoreboard players operation #MarkerMotion.BlockCheck neac_value > #MarkerMotion.north neac_value

    # 6方向の中から最も接触判定が行われた方向を選択する
    # down
    #   upのチェックがなくてdownが1以上あれば有効
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:4b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.down neac_value run data modify storage neac: _.block.ok set value 4b
    # up
    #   downのチェックがなくてupが1以上あれば有効
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:3b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.up neac_value run data modify storage neac: _.block.ok set value 3b
    # east
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:1b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.east neac_value run data modify storage neac: _.block.ok set value 1b
    # west
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:2b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.west neac_value run data modify storage neac: _.block.ok set value 2b
    # south
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:5b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.south neac_value run data modify storage neac: _.block.ok set value 5b
    # north
        execute if data storage neac: _.block{ok:0b} unless data storage neac: _{BounceDirectionDisable:6b} if score #MarkerMotion.BlockCheck neac_value = #MarkerMotion.north neac_value run data modify storage neac: _.block.ok set value 6b


        scoreboard players reset #MarkerMotion.down
        scoreboard players reset #MarkerMotion.up
        scoreboard players reset #MarkerMotion.east
        scoreboard players reset #MarkerMotion.west
        scoreboard players reset #MarkerMotion.south
        scoreboard players reset #MarkerMotion.north
        scoreboard players reset #MarkerMotion.BlockCheck


    # ストレージをスコアに
        execute store result score #MarkerMotion.BlockCheck neac_value run data get storage neac: _.block.ok 1.0

    # 接触したブロックが1tickの間前回と同じのにならないようにする
        data modify storage neac: _.MarkerMotion.BounceDirection set from storage neac: _.block.ok

        # ここが動いたら以降の処理(タグつけたりが動かなくなる仕様)
            execute store result score #MarkerMotion.Bounce.Count neac_value run data get storage neac: _.MarkerMotion.bounce.count 1
            execute if score #MarkerMotion.Bounce.Count neac_value matches -2..-1 run scoreboard players set #MarkerMotion.Bounce.Count neac_value 1
            execute if score #MarkerMotion.BlockCheck neac_value matches 1.. if score #MarkerMotion.Bounce.Count neac_value matches 1.. as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] run function marker_motion:bounce/

    # スコアリセット
        scoreboard players reset #MarkerMotion.Bounce.Count
        scoreboard players reset #MarkerMotion.BlockCheck


