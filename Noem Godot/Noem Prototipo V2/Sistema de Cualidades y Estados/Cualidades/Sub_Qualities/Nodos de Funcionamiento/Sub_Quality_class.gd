extends Node

class_name Sub_Quality

@export var quality_owner : Quality

var entity : CharacterBody2D
var data : data_humanoid
var animations : AnimationPlayer

#@onready var entity: CharacterBody2D = quality_owner.entity
#@onready var data: data_humanoid = quality_owner.data_entity
#@onready var animations : AnimationPlayer = quality_owner.animations_entity

var name_of_subquality : StringName = &"LessName"
	
func action_of_start():
	pass
	
func action():
	pass
	
func action_of_end():
	pass
	
#IMPORTANTE: Este método se tiene que llamar en el ready, DESPUÉS DE ASIGNAR EL NOMBRE A LA SUBCUALIDAD.
func add_subquality_to_the_quality_owner():
	quality_owner.add_subquality_to_the_quality_owner(self, name_of_subquality)

#Cuando una SubCualidad termina, puede usar este método para que el Manager regrese
#a la cualidad por defecto. Es para SubCualidades de un solo uso, como golpear.
func return_to_quality_default():
	quality_owner.qualities_manager.execute_default_quality()
