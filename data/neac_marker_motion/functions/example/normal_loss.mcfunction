summon marker ~ ~ ~ {Tags:["NeAcMarkerMotionExample.Type1","this"],data:{NeAcMarkerMotion:{speed:{amount:100,loss:{amount:0.950,type:"multiply"}}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this