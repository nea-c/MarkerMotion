summon marker ~ ~ ~ {Tags:["NeAcMarkerMotionExample.Type3","this"],data:{NeAcMarkerMotion:{speed:{amount:100},gravity:392.00,bounce:{count:0,e:0.7,g:1b}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this