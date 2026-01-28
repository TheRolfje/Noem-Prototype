extends Node2D

class_name movement_skills

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner

#ESTO NO TIENE SENTIDO: Walk y Run no deberían de existir, solo tiene sentido que exista move_entity_x,
#ya que la ni walk ni run se encargan de hacer la ilusión de que la entidad camina o corre, simplemente
#llaman a la función que mueve a la entidad en X con una velocidad dada. El nombre confunde y la función
#en sí es inutil.
func walk():
	_move_entity_x(data.walk_speed)
	
func run():
	_move_entity_x(data.run_speed)

func _move_entity_x(speed:float):
	entity.velocity.x = data.direction_movement.x * speed
