#example/tick/3
summon marker ~ ~ ~ {Tags:["MarkerMotionExample.Type3","this"],data:{MarkerMotion:{speed:{amount:1.00},gravity:39.200,bounce:{count:-2,e:0.7,g:1b}}}}

execute anchored eyes positioned ^ ^ ^1 positioned ~ ~ ~ run tp @e[type=marker,tag=this] ~ ~ ~ ~ ~

tag @e[type=marker,tag=this] remove this