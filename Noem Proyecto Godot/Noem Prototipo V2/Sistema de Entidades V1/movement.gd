extends Node2D

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner

func walk_rigth():
	_move_entity_x(data.walk_speed)
	#Extrae y ejecuta la animación del nodo de animaciones.
	
func walk_left():
	_move_entity_x(data.walk_speed)
	#Extrae y ejecuta la animación del nodo de animaciones.
	
func run_rigth():
	_move_entity_x(data.run_speed)
	
func run_left():
	_move_entity_x(data.run_speed)

func _move_entity_x(speed:float):
	entity.velocity.x = data.direction_movement.x * speed
