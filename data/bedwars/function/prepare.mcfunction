#function bedwars:reset

# 스폰포인트 변경 활성화
scoreboard players set enable_spawnpoint_set bedwars 1

tellraw @a "플레이어가 모두 준비되면 게임시작을 눌러주세요"
tellraw @a {"text":"[ 게임 시작 ]","color":"green","clickEvent":{"action":"run_command","value":"/function bedwars:start"}}