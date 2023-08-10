#> marker_motion:tp/block/
#
# ブロック接触チェックとか
#
# @within
#   function marker_motion:tp/block/point

# これが呼び出される時は接触したことになるので位置移動と接触チェックを起動する
    data modify storage neac: _.tp[5][].success set value 1b

# ブロックに埋まってたら位置を修復しようとする
    scoreboard players set #MarkerMotion.PosRepair neac_value 10
    execute as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] align xyz unless predicate marker_motion:block_check/shape positioned as @s run function marker_motion:tp/block/pos_repair
    scoreboard players reset #MarkerMotion.PosRepair

## ブロック接触チェック
    # ストレージ初期化
        data modify storage neac: _.block set value {ok:0b,down:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],up:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],south:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],north:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],east:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}],west:[{success:0b},{success:0b},{success:0b},{success:0b},{success:0b}]}

    # 8点をチェックしてストレージにデータを入れる
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~-0.0078125 ~-0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.down[4].success byte 1 store success storage neac: _.block.north[2].success byte 1 store success storage neac: _.block.west[2].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~-0.0078125 ~0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.down[3].success byte 1 store success storage neac: _.block.south[2].success byte 1 store success storage neac: _.block.west[1].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~-0.0078125 ~-0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.down[2].success byte 1 store success storage neac: _.block.north[1].success byte 1 store success storage neac: _.block.east[2].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~-0.0078125 ~0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.down[1].success byte 1 store success storage neac: _.block.south[1].success byte 1 store success storage neac: _.block.east[1].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~0.0078125 ~-0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.up[4].success byte 1 store success storage neac: _.block.north[4].success byte 1 store success storage neac: _.block.west[4].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~-0.0078125 ~0.0078125 ~0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.up[3].success byte 1 store success storage neac: _.block.south[4].success byte 1 store success storage neac: _.block.west[3].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~0.0078125 ~-0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.up[2].success byte 1 store success storage neac: _.block.north[3].success byte 1 store success storage neac: _.block.east[4].success byte 1 run function marker_motion:tp/block/check
        execute positioned as @e[type=marker,tag=MarkerMotion.me,x=0,limit=1] positioned ~0.0078125 ~0.0078125 ~0.0078125 if predicate marker_motion:block_check/condition store success storage neac: _.block.up[1].success byte 1 store success storage neac: _.block.south[3].success byte 1 store success storage neac: _.block.east[3].success byte 1 run function marker_motion:tp/block/check

    # データから接触方向を算出
        function marker_motion:tp/block/contact_check