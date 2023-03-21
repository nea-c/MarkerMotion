#> marker_motion:tp/check
#
# ブロック接触位置
#
# @within
#   function marker_motion:tp/block
#   function marker_motion:tp/pos_repair

# ブロックチェック
    # TP
        tp @s ~ ~ ~
    # TP位置がブロックのどの部分にあたるか見る
    #   空気判定になる場所でtrueを返すのでunless
        execute align xyz unless predicate marker_motion:block_check/shape
