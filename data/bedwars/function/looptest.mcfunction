execute as @a[scores={custom_death=1..}] run tellraw @s ["RespawnLocation: ", {"entity": "@s", "nbt": "SpawnX"}, " ", {"entity": "@s", "nbt": "SpawnY"}, " ", {"entity": "@s", "nbt": "SpawnZ"}]
scoreboard players reset @a[scores={custom_death=1..}] custom_death