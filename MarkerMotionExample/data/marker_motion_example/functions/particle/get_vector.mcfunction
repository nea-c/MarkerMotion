
# 必要なタグとかをつける
    data merge entity @s {Tags:["MarkerMotion.example.vector"]}

    tp @s 0 0 0
# ベクトルを取得
    # Motionを位置とした場所へ移動
        data modify entity @s Pos set from storage marker_motion_example: Motion
    # 移動場所から原点を向く
        execute positioned as @s facing 0.0 0.0 0.0 run tp @s ~ ~ ~ ~ ~

    # 原点に向かって距離の測定
        execute positioned 0.0 0.0 0.0 if entity @s[distance=8..16] run scoreboard players add #MarkerMotionParticleMA neac_value 8
        execute positioned 0.0 0.0 0.0 if entity @s[distance=8..16] at @s run tp @s ^ ^ ^8
        execute positioned 0.0 0.0 0.0 if entity @s[distance=4..8] run scoreboard players add #MarkerMotionParticleMA neac_value 5
        execute positioned 0.0 0.0 0.0 if entity @s[distance=4..8] at @s run tp @s ^ ^ ^4
        execute positioned 0.0 0.0 0.0 if entity @s[distance=2..4] run scoreboard players add #MarkerMotionParticleMA neac_value 2
        execute positioned 0.0 0.0 0.0 if entity @s[distance=2..4] at @s run tp @s ^ ^ ^2
        execute positioned 0.0 0.0 0.0 if entity @s[distance=1..2] run scoreboard players add #MarkerMotionParticleMA neac_value 1
        execute positioned 0.0 0.0 0.0 if entity @s[distance=1..2] at @s run tp @s ^ ^ ^1
        execute positioned 0.0 0.0 0.0 if entity @s[distance=0.5..1] run scoreboard players add #MarkerMotionParticleMA neac_value 1
        execute positioned 0.0 0.0 0.0 if entity @s[distance=0.5..1] at @s run tp @s ^ ^ ^0.5

# 向きを反転して召喚位置に戻る
    execute rotated as @s facing ^ ^ ^-1 run tp @s ~ ~ ~ ~ ~