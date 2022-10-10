#example/tick/1
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type1","this"],data:{MarkerMotion:{speed:{amount:100},gravity:392.00,stopwith:{block:0b}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this