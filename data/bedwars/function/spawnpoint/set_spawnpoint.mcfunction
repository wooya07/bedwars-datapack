# marker의 경우 y좌표 1을 빼주고 dy=0.0001로 감지해야 제대로 감지가 돼서 1 빼기
scoreboard players remove @s bedwars_spawny_temp 1

data merge storage bedwars:temp { spawnLocation: {} }
data modify storage bedwars:temp spawnLocation.x set from entity @s SpawnX
execute store result storage bedwars:temp spawnLocation.y int 1 run scoreboard players get @s bedwars_spawny_temp
data modify storage bedwars:temp spawnLocation.z set from entity @s SpawnZ

execute store result score @s bedwars_player_spawnset_entitycount run function bedwars:spawnpoint/get_existing_marker_count with storage bedwars:temp spawnLocation
execute if score @s bedwars_player_spawnset_entitycount matches 1.. run tellraw @s "다른 사람과 같은 침대에 리스폰 설정을 할 수 없습니다."

# 1 뺀 거 되돌리기
scoreboard players add @s bedwars_spawny_temp 1

# 다른 사람과 같은 침대에 리스폰 설정 시도했을 경우
# - 아직 스폰포인트가 제대로 설정되지 않은 경우 placeholder 값으로 바꾸고 리턴
# - 스폰포인트를 한번이라도 설정한 적이 있다면 이전 값으로 되돌리기
execute as @s[tag=!bedwars_spawn_set] if score @s bedwars_player_spawnset_entitycount matches 1.. run spawnpoint @s 0 10 0
execute as @s[tag=bedwars_spawn_set] if score @s bedwars_player_spawnset_entitycount matches 1.. store result storage bedwars:temp spawnLocation.x int 1 run scoreboard players get @s bedwars_spawnx
execute as @s[tag=bedwars_spawn_set] if score @s bedwars_player_spawnset_entitycount matches 1.. store result storage bedwars:temp spawnLocation.y int 1 run scoreboard players get @s bedwars_spawny
execute as @s[tag=bedwars_spawn_set] if score @s bedwars_player_spawnset_entitycount matches 1.. store result storage bedwars:temp spawnLocation.z int 1 run scoreboard players get @s bedwars_spawnz
execute as @s[tag=bedwars_spawn_set] if score @s bedwars_player_spawnset_entitycount matches 1.. run function bedwars:spawnpoint/revert with storage bedwars:temp spawnLocation

execute if score @s bedwars_player_spawnset_entitycount matches 1.. run return 0

# 해당 리스폰지점에 마커 소환 (이미 소환되어 있다면 kill하고 다시 소환)
execute at @a if score @p bedwars_player_id = @s bedwars_player_id as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id run kill @s
$summon marker $(SpawnX) $(SpawnY) $(SpawnZ) {Tags: ["bedwars_bed"]}

# 플레이어 id와 연동
function bedwars:spawnpoint/link_player with storage bedwars:temp spawnLocation

tag @s add bedwars_spawn_set
scoreboard players operation @s bedwars_spawnx = @s bedwars_spawnx_temp
scoreboard players operation @s bedwars_spawny = @s bedwars_spawny_temp
scoreboard players operation @s bedwars_spawnz = @s bedwars_spawnz_temp
