#> marker_motion:tp/shulker/check
#
# シュルカー接触位置
#
# @within
#   function marker_motion:tp/shulker/

# シュルカーチェック
    # TP
        tp @s ~ ~ ~
    # TP位置がシュルカー内にいるか見る
        execute positioned as @e[type=shulker,tag=MarkerMotion.hitShulker,distance=..5,limit=1] if predicate marker_motion:shulker
