extends Node

@export var walk_speed:float = 0
@export var run_speed:float = 0

var direction_look:Vector2
#Contempla mirar hacia la derecha e izquierda (x),
#arriba y abajo (y)
#y en diagonal (x,y)

var direction_movement:Vector2

func set_direction_move(dir:Vector2):
	direction_movement = dir
	
func set_direction_move_x(dir:int):
	direction_movement.x = dir
	
func set_direction_move_y(dir:int):
	direction_movement.y = dir
	
func set_walk_speed(speed:float):
	walk_speed = speed
