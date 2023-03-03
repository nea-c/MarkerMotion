#example/tick/3
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type3","this"],data:{MarkerMotion:{speed:{amount:100},gravity:392.00,bounce:{count:-1,e:0.7,g:1b}}}}

execute anchored eyes positioned ^ ^ ^0.3 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this