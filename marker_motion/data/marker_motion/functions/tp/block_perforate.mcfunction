#> marker_motion:tp/block_perforate
#
# 移動先目標までの間をターゲットエンティティがいるか探す処理
# ヒットボックスでのヒットを行ったりできる
#
# @within function marker_motion:tp/

# 前方にtpしていく　どんどん細かくする
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.2] if block ^ ^ ^0.2 #marker_motion:no_collision run tp @s ^ ^ ^0.2
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.1] if block ^ ^ ^0.1 #marker_motion:no_collision run tp @s ^ ^ ^0.1
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.05] if block ^ ^ ^0.05 #marker_motion:no_collision run tp @s ^ ^ ^0.05
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.025] if block ^ ^ ^0.025 #marker_motion:no_collision run tp @s ^ ^ ^0.025
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.0125] if block ^ ^ ^0.0125 #marker_motion:no_collision run tp @s ^ ^ ^0.0125
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.00625] if block ^ ^ ^0.00625 #marker_motion:no_collision run tp @s ^ ^ ^0.00625
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.003125] if block ^ ^ ^0.003125 #marker_motion:no_collision run tp @s ^ ^ ^0.003125
    execute at @s unless entity @e[tag=MarkerMotion.this,limit=1,distance=..0.003125] if block ^ ^ ^0.003125 #marker_motion:no_collision run tp @s ^ ^ ^0.003125
