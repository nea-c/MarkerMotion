#> marker_motion:tp/points
#
# ブロック接触位置
#
# @within
#   function marker_motion:tp/0016

# ブロック接触検知場所にTP
    tp @s ~ ~ ~

# ブロック接触チェック等
    execute unless data storage neac: _.MarkerMotion.stopwith{block:0b} run function marker_motion:block
