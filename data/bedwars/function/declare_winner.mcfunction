scoreboard objectives add finish_seconds dummy

#만약에 문제 생기면 아래 코드의 @S 를 @A로 바꿀것
#단 끝날때마다 인원수 만큼 END FUNCTION 실행
scoreboard players set @s finish_seconds 0
#5초후 리셋 창을 띄우기 위함
tag @a add finished

# 1. 우승 메시지 출력
playsound item.goat_horn.sound.1 master @a ~ ~ ~ 1000 1 1
execute as @a[tag=!bedwars_eliminated,limit=1] run title @a title [{ "selector": "@s","color":"yellow" },{"text":"님이 우승했습니다", "color": "white"}] 

# 2. 리셋 타이머 설정(reset_timer 함수에서 리셋 실행)
scoreboard players set @s goldtimer_s 4
scoreboard players set @s goldtimer_ms 1
scoreboard players set @s goldtimer 0

