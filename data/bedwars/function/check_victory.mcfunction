# bedwars_eliminated 태그가 있는 모든 플레이어를 탐지하여 스코어 증가
execute as @a[tag=bedwars_eliminated] run scoreboard players add eliminated EliminatedCount 1

scoreboard players set winner EliminatedCount 0
scoreboard players operation winner EliminatedCount = $total bedwars_bed_id
scoreboard players remove winner EliminatedCount 1

execute if score eliminated EliminatedCount >= winner EliminatedCount run function bedwars:declare_winner
scoreboard players set winner EliminatedCount 0
