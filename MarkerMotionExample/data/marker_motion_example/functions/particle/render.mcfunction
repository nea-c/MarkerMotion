scoreboard players remove #MarkerMotionParticleMA neac_value 1
particle electric_spark ^ ^ ^ 0 0 0 0 1 force @a
execute if score #MarkerMotionParticleMA neac_value matches 0.. positioned ^ ^ ^0.1 run function marker_motion_example:particle/render