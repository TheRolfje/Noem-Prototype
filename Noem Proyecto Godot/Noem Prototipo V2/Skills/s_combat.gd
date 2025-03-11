extends Node2D

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner

func take_damage():
	var attack:object_attack = data.attack_received
	
	data.health = max(data.health - attack.damage, 0)
	#max impide que reciba valores menores a 0.
	
	if(data.health == 0):
		entity.queue_free()
	
func set_damage(entity:CharacterBody2D):
	pass
	
	
