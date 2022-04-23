summon marker ~ ~ ~ {Tags:["NeAcMarkerMotionExample.Type2","this"],data:{NeAcMarkerMotion:{speed:{amount:100},stopwith:{hit:1b}}}}

execute anchored eyes positioned ^ ^ ^0.6 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this