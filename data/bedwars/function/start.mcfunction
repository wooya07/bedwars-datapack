# 스폰지점 철거
fill -5 -1 -5 5 1 5 air
fill -50 -1 -50 -25 33 -25 air replace minecraft:smooth_stone_slab
fill 50 -1 50 25 33 25 air replace minecraft:smooth_stone_slab
fill -50 -1 50 -25 33 25 air replace minecraft:smooth_stone_slab
fill 50 -1 -50 25 33 -25 air replace minecraft:smooth_stone_slab
fill -25 -1 -25 0 33 0 air replace minecraft:smooth_stone_slab
fill 25 -1 25 0 33 0 air replace minecraft:smooth_stone_slab
fill 25 -1 -25 0 33 0 air replace minecraft:smooth_stone_slab
fill -25 -1 25 0 33 0 air replace minecraft:smooth_stone_slab
fill -25 -1 -25 -50 33 0 air replace minecraft:smooth_stone_slab
fill -25 -1 25 -50 33 0 air replace minecraft:smooth_stone_slab
fill -25 -1 25 0 33 50 air replace minecraft:smooth_stone_slab
fill 25 -1 25 0 33 50 air replace minecraft:smooth_stone_slab
fill 25 -1 25 50 33 0 air replace minecraft:smooth_stone_slab
fill 25 -1 -25 50 33 0 air replace minecraft:smooth_stone_slab
fill 25 -1 -25 0 33 -50 air replace minecraft:smooth_stone_slab
fill -25 -1 -25 0 33 -50 air replace minecraft:smooth_stone_slab

# 게임 시작 처리
scoreboard players set started bedwars 1
scoreboard players set enable_spawnpoint_set bedwars 0

clear @a
kill @e[type=text_display,tag=helptext]
# 랜덤 아이템 지급 시작
# 플레이어가 실행할 경우 settings 메세지가 떠서, 이를 방지하고자 플레이어가 아닌 엔티티가 실행
execute as @n[type=!player] run function randomitemgiver:settings/continue

tellraw @a [{"text":"게임이 시작되었습니다","color":"green","bold":true}]

playsound item.goat_horn.sound.0 master @a ~ ~ ~ 1000 1 1

#데스매치 타임 시작
scoreboard players set @a deathmatchtimer 0
