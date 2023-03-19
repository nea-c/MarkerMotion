# 移動距離と移動角度取得
    data modify entity @s Rotation set from storage marker_motion_example: Move.Rotation
    execute store result score #MarkerMotionParticleMA neac_value run data get storage marker_motion_example: Move.Amount 10

# 変更した移動距離とスコアに出した移動角度でパーティクルを出す
    execute rotated as @s facing ^ ^ ^-1 run function marker_motion_example:particle/render

# 後処理
    kill @s
    scoreboard players reset #MarkerMotionParticleMA
