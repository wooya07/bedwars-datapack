# 필드 초기화
fill -50 -1 -50 -25 33 -25 air
fill 50 -1 50 25 33 25 air
fill -50 -1 50 -25 33 25 air
fill 50 -1 -50 25 33 -25 air
fill -25 -1 -25 0 33 0 air
fill 25 -1 25 0 33 0 air
fill 25 -1 -25 0 33 0 air
fill -25 -1 25 0 33 0 air
fill -25 -1 -25 -50 33 0 air
fill -25 -1 25 -50 33 0 air
fill -25 -1 25 0 33 50 air
fill 25 -1 25 0 33 50 air
fill 25 -1 25 50 33 0 air
fill 25 -1 -25 50 33 0 air
fill 25 -1 -25 0 33 -50 air
fill -25 -1 -25 0 33 -50 air

# 로비 리셋
setblock -9 -1 -9 structure_block{mode: "LOAD", name: "minecraft:deathmatch", posY: 1}
setblock -9 -2 -9 redstone_block
fill -9 -1 -9 -9 -2 -9 air

#
scoreboard players set @a dtimer 0
scoreboard players set @a dtimer_s 5

tp @a 0 1 0
effect give @a instant_health 5
effect give @a saturation 5
effect give @a resistance 5

tag @a add overtime

summon text_display 0.5 2.5 -2.5 {Tags: ["helptext"], text: '["도움말"]',alignment:"center"}
execute as @n[type=!player] run function randomitemgiver:settings/pause
kill @e[type=!player]