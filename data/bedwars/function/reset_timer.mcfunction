scoreboard objectives add goldtimer dummy
scoreboard objectives add goldtimer_s dummy
scoreboard objectives add goldtimer_ms dummy




scoreboard players add @a goldtimer 1

scoreboard players remove @a[scores={goldtimer=2}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=4}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=6}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=8}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=10}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=12}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=14}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=16}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=18}] goldtimer_ms 1
scoreboard players remove @a[scores={goldtimer=20}] goldtimer_ms 1

scoreboard players remove @a[scores={goldtimer=20}] goldtimer_s 1

# execute if score @s goldtimer matches 20 run scoreboard players set @a goldtimer 0
# execute if score @s goldtimer_s matches 60 run scoreboard players set @a goldtimer_s 0

# 5초마다 1회전 초기화
scoreboard players set @a[scores={goldtimer=20..}] goldtimer 0
# 4초마다 초 초기화
scoreboard players set @a[scores={goldtimer_s=-1}] goldtimer_s 0
# 1초마다 0.1초 초기화
scoreboard players set @a[scores={goldtimer_ms=-1}] goldtimer_ms 9



execute as @a[tag=finished] run title @s actionbar [{ "text": "재시작까지 : "},{"score": {"name":"*","objective":"goldtimer_s"}},{"text":"."},{"score":  {"name": "*","objective":"goldtimer_ms"}}]


scoreboard players add @a finish_seconds 1

execute as @a[tag=finished] as @s[scores={finish_seconds=100}] run function bedwars:end