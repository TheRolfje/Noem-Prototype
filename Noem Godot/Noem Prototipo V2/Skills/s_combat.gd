extends Node2D

class_name combat_skills

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner

#ESTE METODO DEBERÍA ÚNICO PARA CADA ENTIDAD O MUCHO MÁS GENERAL.
func take_damage():
	var attack:object_attack = data.attack_received
	
	#data.health = max(data.health - attack.damage, 0)
	#max impide que reciba valores menores a 0.
	
	if(data.health == 0):
		entity.queue_free()
	
func set_damage(entity:CharacterBody2D):
	pass
	
	
