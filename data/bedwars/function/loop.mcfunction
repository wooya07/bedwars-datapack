# 확인된느 모든 플레이어한테 id 할당
# 게임 중간에 들어와도 id가 꼬이는 일 방지
scoreboard players add @a bedwars_player_id 0
execute as @a[scores={bedwars_player_id=0}] run function bedwars:init_id


# =====

# 모든 플레이어의 리스폰 위치를 백업
execute if score enable_spawnpoint_set bedwars matches 1 as @a store result score @s bedwars_spawnx_temp run data get entity @s SpawnX
execute if score enable_spawnpoint_set bedwars matches 1 as @a store result score @s bedwars_spawny_temp run data get entity @s SpawnY
execute if score enable_spawnpoint_set bedwars matches 1 as @a store result score @s bedwars_spawnz_temp run data get entity @s SpawnZ

# 이전에 설정한 스폰지점과 동일한 경우 검사를 건너뜀
execute if score enable_spawnpoint_set bedwars matches 1 as @a if score @s bedwars_spawnx = @s bedwars_spawnx_temp if score @s bedwars_spawny = @s bedwars_spawny_temp if score @s bedwars_spawnz = @s bedwars_spawnz_temp run tag @s add bedwars_player_spawnpos_unchanged
# 게임 시작할 때 지정된 placeholder 스폰 지점(0,10,0)일 경우에도 검사를 건너뜀
execute if score enable_spawnpoint_set bedwars matches 1 as @a if score @s bedwars_spawnx_temp matches 0 if score @s bedwars_spawny_temp matches 10 if score @s bedwars_spawnz_temp matches 0 run tag @s add bedwars_player_spawnpos_unchanged

# 검사 건너뜀 tag가 없을 경우 침대 우클릭 등으로 새로 리스폰 지점을 설정했다고 간주
execute if score enable_spawnpoint_set bedwars matches 1 as @a[tag=!bedwars_player_spawnpos_unchanged] run function bedwars:spawnpoint/set_spawnpoint with entity @s
tag @a[tag=bedwars_player_spawnpos_unchanged] remove bedwars_player_spawnpos_unchanged

# ======

# 아래 코드는 게임 시작했을때만 실행
execute if score started bedwars matches 0 run return 0

# 플레이어가 죽었을 경우 리스폰이 가능한지 절차 체크 시작
tag @a[scores={bedwars_player_death=1..}] add bedwars_respawn_process
scoreboard players reset @a[scores={bedwars_player_death=1..}] bedwars_player_death

# 일단 관전자로 바꾸고
execute as @a[tag=bedwars_respawn_process] at @s run gamemode spectator @s

# 리스폰 지점이 세팅되어 있지 않을 경우 탈락
execute as @a[tag=bedwars_respawn_process,tag=!bedwars_spawn_set] run function bedwars:internal/eliminate_player

# 리스폰 위치 저장된 거에서부터 트래킹 시작

# 해당 좌표에 침대가 없으면 탈락
# execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id if block ~ ~ ~ #minecraft:beds run say 1
# execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id unless block ~ ~ ~ #minecraft:beds run say 0
# execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id if block ~ ~ ~ air run say air
# execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id unless block ~ ~ ~ #minecraft:beds as @p run function bedwars:internal/eliminate_player
execute at @e[type=marker,tag=bedwars_bed] as @a[tag=bedwars_respawn_process] if score @s bedwars_player_id = @n[type=marker,tag=bedwars_bed] bedwars_bed_id unless block ~ ~ ~ #minecraft:beds run function bedwars:internal/eliminate_player

execute at @e[type=marker,tag=bedwars_bed] as @a[tag=bedwars_respawn_process] if score @s bedwars_player_id = @n[type=marker,tag=bedwars_bed] bedwars_bed_id run summon marker ~ ~ ~ {Tags: ["bedwars_respawn_marker"]}
# execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id run summon marker ~ ~ ~ {Tags: ["bedwars_respawn_marker"]}
execute at @a[tag=bedwars_respawn_process] as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id run scoreboard players operation @e[type=marker,tag=bedwars_respawn_marker,sort=nearest,limit=1] bedwars_respawncheck_marker_id = @s bedwars_bed_id

scoreboard players set @a[tag=bedwars_respawn_process] bedwars_respawn_countdown 100
tag @a[tag=bedwars_respawn_process] add bedwars_respawn_countdown
tag @a[tag=bedwars_respawn_process] remove bedwars_respawn_process

# execute as @a[tag=bedwars_respawn_countdown] run say 0
# execute as @n[tag=bedwars_respawn_marker] run say 1

# =====

execute at @a[tag=bedwars_respawn_countdown] as @e[type=marker,tag=bedwars_respawn_marker,tag=!bedwars_respawnpoint_found] if score @s bedwars_respawncheck_marker_id = @p bedwars_player_id at @s run tp ~ ~1 ~
execute at @a[tag=bedwars_respawn_countdown] as @e[type=marker,tag=bedwars_respawn_marker,tag=!bedwars_respawnpoint_found] if score @s bedwars_respawncheck_marker_id = @p bedwars_player_id at @s if block ~ ~ ~ air if block ~ ~1 ~ air run tag @s add bedwars_respawnpoint_found

# 카운트다운
execute as @a[tag=goldtimerreset] as @s run function bedwars:set_goldtimer0

execute as @a[tag=bedwars_respawn_countdown] run title @s actionbar ["부활까지: ", {"score": {"name": "@s", "objective": "bedwars_respawn_countdown"}}]
scoreboard players remove @a[tag=bedwars_respawn_countdown] bedwars_respawn_countdown 1

# 카운트다운이 0이라면 실제 리스폰 좌표로 tp시킨 후 서바이벌로 전환
execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 at @s as @e[type=marker,tag=bedwars_respawn_marker] if score @s bedwars_respawncheck_marker_id = @p bedwars_player_id run tp @p @s
execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 at @s run tp @s ~ ~ ~
execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 run gamemode survival @s
execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 at @s as @e[type=marker,tag=bedwars_respawn_marker] if score @s bedwars_respawncheck_marker_id = @p bedwars_player_id run kill @s

# execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 run tag @s remove bedwars_respawnpoint_found
execute as @a[tag=bedwars_respawn_countdown] if score @s bedwars_respawn_countdown matches ..-1 run tag @s remove bedwars_respawn_countdown