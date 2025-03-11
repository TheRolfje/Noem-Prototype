extends Node

var noem:CharacterBody2D

@export var walk_speed:float = 0
@export var run_speed:float = 0

var distraida:bool = false
var direccion_distraida:int

enum Emociones {enojada, triste, asustada, feliz}
var emocion_activa = Emociones.feliz

var distancia_de_seguimiento_max:float = 100
var distancia_de_seguimiento_min:float = 90

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
