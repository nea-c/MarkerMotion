
#data.MarkerMotion.Moveのデータからパーティクルを発生させる
    data modify storage marker_motion_example: Move set from entity @s data.MarkerMotion.Move
    execute summon marker run function marker_motion_example:particle/get_vector
    data remove storage marker_motion_example: Move
