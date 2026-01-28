extends CharacterBody2D

class_name Noem_Entity

@export var sm_acciones:Node2D
@export var data:data_humanoid

func _ready():
	add_to_group("Noem")
	add_to_group("Humanoid_Entity")

func _physics_process(delta):
	
	velocity += get_gravity() * delta
	
	sm_acciones.action_of_active_state()

	move_and_slide()
