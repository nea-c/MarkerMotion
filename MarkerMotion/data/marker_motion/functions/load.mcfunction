#> marker_motion:load
#
# ロード時に読まれるコマンド
#
# @within tag/function minecraft:load

# スコアオブジェクト作成
    scoreboard objectives add neac_value dummy

# 固定値スコア設定
    scoreboard players set #1000 neac_value 1000