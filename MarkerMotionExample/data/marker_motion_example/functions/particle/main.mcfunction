#data.MarkerMotion.Motionのデータからパーティクルを発生させる処理

data modify storage marker_motion_example: Motion set from entity @s data.MarkerMotion.Motion
execute summon marker run function marker_motion_example:particle/get_vector
data remove storage marker_motion_example: Motion

execute rotated as @e[type=marker,tag=MarkerMotion.example.vector,limit=1] run function marker_motion_example:particle/render
kill @e[type=marker,tag=MarkerMotion.example.vector,limit=1]

scoreboard players reset #MarkerMotionParticleMA
