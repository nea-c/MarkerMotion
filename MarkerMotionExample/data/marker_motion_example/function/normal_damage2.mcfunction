#example/tick/2
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type2","this"],data:{MarkerMotion:{speed:{amount:1.00},stopwith:{hit:0b}}}}

execute anchored eyes positioned ^ ^ ^0.6 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this