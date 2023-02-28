#> marker_motion:load
#
# ロード時に読まれるコマンド
#
# @within tag/function minecraft:load

# スコアオブジェクト作成
    scoreboard objectives add neac_value dummy

# 100,1000,-1の値を仮想プレイヤーからもらえるように設定
    scoreboard players set #100 neac_value 100
    scoreboard players set #1000 neac_value 1000
    scoreboard players set #-1 neac_value -1