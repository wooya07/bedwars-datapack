# 해당 위치에 이미 누가 리스폰을 찍어놨다면 내가 리스폰을 찍을 수 없음
# TODO: 동일틱 동일침대 우클릭으로 리스폰찍는 경우는 확인필요
$return run execute if entity @e[x=$(x),y=$(y),z=$(z),dx=0,dy=0.0001,dz=0,type=marker,tag=bedwars_bed]
