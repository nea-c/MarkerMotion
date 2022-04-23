summon marker ~ ~ ~ {Tags:["NeAcMarkerMotionExample.Type1","this"],data:{NeAcMarkerMotion:{speed:{amount:100},gravity:392.00}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this