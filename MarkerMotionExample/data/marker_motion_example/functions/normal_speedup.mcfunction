#example/tick/1
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type1","MarkerMotionExample.SPEEDUP","this"],data:{MarkerMotion:{speed:{amount:0.10,loss:{amount:1.1,type:"*"}}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this