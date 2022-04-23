scoreboard players remove #NeAcMarkerMotionParticleMA neac_value 1
particle dust 0.592 0.918 0.243 1 ^ ^ ^ 0 0 0 0 1 force @a
execute if score #NeAcMarkerMotionParticleMA neac_value matches 0.. positioned ^ ^ ^-0.5 if block ~ ~ ~ #neac_marker_motion:no_collision run function neac_marker_motion:example/particle/render