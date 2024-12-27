scoreboard players set enable_spawnpoint_set bedwars 0
scoreboard players set started bedwars 0

# 데스카운트 리셋
scoreboard players reset @a bedwars_player_death

# 플레이어 id 시스템 리셋
scoreboard objectives remove bedwars_player_id
scoreboard objectives add bedwars_player_id dummy
scoreboard players set $total bedwars_player_id 0

#데스매치까지 남은 시간 리셋
scoreboard objectives add deathmatchtimer dummy
scoreboard players set @a deathmatchtimer 20000
#10분이 12,000틱이므로 20,000 으로 잡음 만약 10분보다 늘릴경우 해당 부분도 수정 필요


scoreboard objectives remove bedwars_bed_id
scoreboard objectives add bedwars_bed_id dummy
scoreboard objectives remove bedwars_respawncheck_marker_id
scoreboard objectives add bedwars_respawncheck_marker_id dummy

scoreboard objectives remove bedwars_respawn_countdown
scoreboard objectives add bedwars_respawn_countdown dummy

spawnpoint @a 0 10 0
scoreboard players reset @a bedwars_spawnx
scoreboard players reset @a bedwars_spawny
scoreboard players reset @a bedwars_spawnz
scoreboard players reset @a bedwars_spawnx_temp
scoreboard players reset @a bedwars_spawny_temp
scoreboard players reset @a bedwars_spawnz_temp

scoreboard players reset @e[type=marker,tag=bedwars_bed]
scoreboard players reset @e[type=marker,tag=bedwars_respawn_marker]
kill @e[type=marker,tag=bedwars_bed]
kill @e[type=marker,tag=bedwars_respawn_marker]
kill @e[type=item]

tag @a remove bedwars_spawn_set
tag @a remove bedwars_respawn_countdown
tag @a remove bedwars_eliminated


# 랜덤 아이템 지급 중단
# 플레이어가 실행할 경우 settings 메세지가 떠서, 이를 방지하고자 플레이어가 아닌 엔티티가 실행
summon text_display 0.5 2.5 -2.5 {Tags: ["helptext"], text: '["도움말"]',alignment:"center"}
execute as @n[type=!player] run function randomitemgiver:settings/pause

# 로비 리셋
setblock -5 -2 -5 structure_block{mode: "LOAD", name: "minecraft:bedwars_spawn", posY: 1}
setblock -5 -2 -6 redstone_block
fill -5 -2 -5 -5 -2 -6 air

kill @e[type=text_display,tag=helptext]
summon text_display 0.5 1.5 4.5 {Tags: ["helptext"], text: '[{"text": "[도움말]", "color":"yellow"},{"text": "\\n/function bedwars:help","color":"white"}]',alignment:"center",billboard:"fixed",Rotation:[180F,0F]}

scoreboard objectives add EliminatedCount dummy
# 스코어 초기화
scoreboard players set eliminated EliminatedCount 0