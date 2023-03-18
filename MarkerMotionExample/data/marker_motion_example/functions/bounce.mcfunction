#example/tick/1
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type1","this"],data:{MarkerMotion:{speed:{amount:1.00},bounce:{count:-1}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this