#example/tick/1
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type1","this"],data:{MarkerMotion:{speed:{amount:100,loss:{amount:2,type:"constant"}}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this