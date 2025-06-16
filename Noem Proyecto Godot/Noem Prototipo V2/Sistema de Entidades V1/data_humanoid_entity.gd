extends Data_class

class_name data_humanoid

var continue_the_process:bool = true
var action_pressed:bool = true

@export var entity_name:String = "entity"

@export var walk_speed:float = 0
@export var run_speed:float = 0
@export var health:int = 1
@export var damage:int = 0

enum emotions {HAPPY,ANGRY,FEAR,NEUTRAL,ALERT}
var emotional_state:emotions = emotions.NEUTRAL

enum Terrain {NEUTRAL_TERRAIN,SLOPE,LADDER}
var moving_in:Terrain = Terrain.NEUTRAL_TERRAIN

var climbing_slope:bool = false
var ladder:bool = false

var attack_received:object_attack = null
var objetivo_atacado:CharacterBody2D = null

var direction_look:Vector2 = Vector2.RIGHT
#Contempla mirar hacia la derecha e izquierda (x),
#arriba y abajo (y)
#y en diagonal (x,y)

var direction_movement:Vector2 = Vector2.RIGHT

func set_direction_move(dir:Vector2):
	direction_movement = dir
	
func set_direction_move_x(dir:int):
	direction_movement.x = dir
	
func set_direction_move_y(dir:int):
	direction_movement.y = dir
	
func set_walk_speed(speed:float):
	walk_speed = speed
	
func on_off_climbing_slope():
	climbing_slope =! climbing_slope
	
	if(moving_in == Terrain.SLOPE):
		moving_in = Terrain.NEUTRAL_TERRAIN
	else:
		moving_in = Terrain.SLOPE
	
func on_off_ladder():
	if(moving_in == Terrain.LADDER):
		moving_in = Terrain.NEUTRAL_TERRAIN
	else:
		moving_in = Terrain.LADDER
