#> marker_motion:tp/point
#
# ブロック接触位置
#
# @within
#   function marker_motion:tp/0016

# successリセット
    data modify storage neac: _.success set value 0b

# ブロックチェック
    # TP
        tp @e[type=marker,tag=MarkerMotion.me,limit=1] ~ ~ ~
    # TP位置がブロックのどの部分にあたるか見る
    #   空気判定になる場所でtrueを返すのでunless
        execute as @e[type=marker,tag=MarkerMotion.me,limit=1] align xyz store success storage neac: _.success byte 1 unless predicate marker_motion:block_check/shape

    # ブロック接触チェック等
    execute if data storage neac: _{success:1b} unless data storage neac: _.MarkerMotion.stopwith{block:0b} positioned as @e[type=marker,tag=MarkerMotion.me,limit=1] run function marker_motion:tp/block
