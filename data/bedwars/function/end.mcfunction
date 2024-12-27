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

# 내부 리셋
tag @a remove finished
kill @e
function bedwars:reset


# execute as @n[type=!player] run function randomitemgiver:settings/pause
clear @a

gamemode survival @a

function bedwars:prepare

