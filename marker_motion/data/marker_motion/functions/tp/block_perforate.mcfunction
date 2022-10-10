#> marker_motion:tp/block_perforate
#
# ブロックに接触しても止まらないようにする処理
#
# @within function marker_motion:tp/

# 前方にtpしていく　どんどん細かくする
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.2] run tp @s ^ ^ ^0.2
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.1] run tp @s ^ ^ ^0.1
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.05] run tp @s ^ ^ ^0.05
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.025] run tp @s ^ ^ ^0.025
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.0125] run tp @s ^ ^ ^0.0125
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.00625] run tp @s ^ ^ ^0.00625
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.003125] run tp @s ^ ^ ^0.003125
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.003125] run tp @s ^ ^ ^0.003125
