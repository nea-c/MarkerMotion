#> marker_motion:tp/block/check
#
# ブロック接触位置
#
# @within
#   function marker_motion:tp/block/block
#   function marker_motion:tp/block/pos_repair

# ブロックチェック
    # TP
        tp @s ~ ~ ~
    # TP位置がブロックのどの部分にあたるか見る
    #   空気判定になる場所でtrueを返すのでunless
        return run execute align xyz if predicate marker_motion:block_check/shape
