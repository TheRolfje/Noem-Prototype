extends Data_class

#SEPARAR ESTA DATA EN VARIAS DATAS ENCARGADAS DE VARIAS COSAS.

class_name data_humanoid

var continue_the_process:bool = true
var action_pressed:bool = true

@export var entity_name:String = "entity"

@export var walk_speed:float = 0
@export var run_speed:float = 0
@export var health:int = 1
@export var damage:int = 0

#Posibles estados de la Entidad.-----------------------
var active_emotional_state : StringName
var active_locomotional_state : StringName
var active_physical_state : StringName
var active_protection_state : StringName

var active_quality : StringName
#-------------------------------------------------------

#Aca se registran el estado o cualidad anterior al activado.
@onready var old_emotional_state : StringName = &""
@onready var old_locomotional_state : StringName = &""
@onready var old_physical_state : StringName = &""
@onready var old_protection_state : StringName = &""

@onready var old_quality : StringName = &""
#Por defecto estan vacios para evitar errores de comparación, por las dudas.
#-------------------------------------------------------

func change_state_labels(new_state : StringName, type : StringName):
	match type:
		State_Type.LOCOMOTIONAL:
			old_locomotional_state = active_locomotional_state
			active_locomotional_state = new_state
		State_Type.EMOTIONAL:
			old_emotional_state = active_emotional_state
			active_emotional_state = new_state
		State_Type.PHYSICAL:
			old_physical_state = active_physical_state
			active_physical_state = new_state
		State_Type.PROTECTION:
			old_protection_state = active_protection_state
			active_protection_state = new_state
		
func chande_active_quality(new_quality):
	old_quality = active_quality
	active_quality = new_quality
#------------------------------------------------------

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
	
#func on_off_climbing_slope():
	#climbing_slope =! climbing_slope
	#
	#if(moving_in == Terrain.SLOPE):
		#moving_in = Terrain.NEUTRAL_TERRAIN
	#else:
		#moving_in = Terrain.SLOPE
	#
#func on_off_ladder():
	#if(moving_in == Terrain.LADDER):
		#moving_in = Terrain.NEUTRAL_TERRAIN
	#else:
		#moving_in = Terrain.LADDER
