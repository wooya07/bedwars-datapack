scoreboard objectives add dtimer dummy
scoreboard objectives add dtimer_s dummy

scoreboard players add @a deathmatchtimer 1
scoreboard players add @a dtimer 1

scoreboard players remove @a[scores={dtimer=20}] dtimer_s 1

# 5초마다 1회전 초기화
scoreboard players set @a[scores={dtimer=20..}] dtimer 0
# 4초마다 초 초기화
scoreboard players set @a[scores={dtimer_s=-1}] dtimer_s 0

# 1초마다 노트블럭 알림음
execute as @a[tag=overtime] as @a[scores={dtimer=0}] run playsound minecraft:block.note_block.bit master @a

# 시간초 보여주기
execute as @a[tag=overtime] run title @a actionbar [{ "text": "데스매치 시작까지 : "},{"score": {"name":"*","objective":"dtimer_s"},"color": "yellow"},{"text":"초 남았습니다"}]
execute as @a[tag=overtime] as @a[scores={dtimer_s=0}] run title @a actionbar [{"text": "데스매치 시작!","color": "green"}]
execute as @a[tag=overtime] as @a[scores={dtimer_s=0}] run playsound item.goat_horn.sound.0 master @a ~ ~ ~ 1000 1 1

# 5초후 시간 안보이게
execute as @a[scores={dtimer_s=0}] run tag @a remove overtime

# 게임시작 10분후 데스매치 시작
# 12000틱 = 10분
execute as @a[scores={deathmatchtimer=12000}] run function bedwars:deathmatch

# execute as @a[scores={deathmatchtimer=60}] run title @a subtitle [{"text": "데스매치 시작까지"},{"text": "5분","color": "yellow"},{"text": "남았습니다"}]
# execute as @a[scores={deathmatchtimer=10800}] run title @a subtitle [{"text": "데스매치 시작까지"},{"text": "1분","color": "yellow"},{"text": "남았습니다"}]
execute as @a[scores={deathmatchtimer=6000}] run tellraw @a [{"text": "데스매치 시작까지"},{"text": " 5분 ","color": "yellow"},{"text": "남았습니다"}]
execute as @a[scores={deathmatchtimer=10800}] run tellraw @a [{"text": "데스매치 시작까지"},{"text": " 1분 ","color": "yellow"},{"text": "남았습니다"}]