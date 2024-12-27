scoreboard objectives add finish_seconds dummy

#만약에 문제 생기면 아래 코드의 @S 를 @A로 바꿀것
#단 끝날때마다 인원수 만큼 END FUNCTION 실행
scoreboard players set @s finish_seconds 0

tag @a add finished

# 1. 우승 메시지 출력
playsound item.goat_horn.sound.1 master @a ~ ~ ~ 1000 1 1
execute as @a[tag=!bedwars_eliminated,limit=1] run title @a title [{ "selector": "@s","color":"yellow" },{"text":"님이 우승했습니다", "color": "white"}] 

# 2. 게임 종료 또는 리셋 (선택 사항)
scoreboard players set @a goldtimer_s 4
scoreboard players set @a goldtimer_ms 1
scoreboard players set @a goldtimer 0



# execute if score @s goldtimer matches 20 run function bedwars:end

# execute as @a if score @s goldtimer_ms matches 0 run function bedwars:end

