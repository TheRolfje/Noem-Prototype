extends Node2D

class_name movement_skills

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner

func walk():
	_move_entity_x(data.walk_speed)
	
func run():
	_move_entity_x(data.run_speed)

func _move_entity_x(speed:float):
	entity.velocity.x = data.direction_movement.x * speed
