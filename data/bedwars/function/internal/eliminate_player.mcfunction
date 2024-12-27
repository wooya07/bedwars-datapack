# 실행한 사람이 탈락됨

tag @s add bedwars_eliminated
title @a title [{"selector": "@s"},{"text": " 탈락","color":"red"}]
# title @a subtitle [{"selector": "@s"}, " 님의 침대가 파괴되었습니다."]


# 연결된 침대 마커 및 임시 리스폰지점 마커 kill
execute at @s as @e[type=marker,tag=bedwars_bed] if score @s bedwars_bed_id = @p bedwars_player_id run kill @s
execute at @s as @e[type=marker,tag=bedwars_respawn_marker] if score @s bedwars_respawnpoint_id = @p bedwars_player_id run kill @s

tag @s remove bedwars_respawn_process

function bedwars:check_victory