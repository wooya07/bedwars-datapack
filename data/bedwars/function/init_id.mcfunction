# 총 id개수를 1 올리고
scoreboard players add $total bedwars_player_id 1
scoreboard players add $totalmone bedwars_bed_id 1

# 새로운 id를 할당
scoreboard players operation @s bedwars_player_id = $total bedwars_player_id
