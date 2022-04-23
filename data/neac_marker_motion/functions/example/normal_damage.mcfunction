#example/tick/2
summon marker ~ ~ ~ {Tags:["NeAcMarkerMotionExample.Type2","this"],data:{NeAcMarkerMotion:{speed:{amount:100}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this