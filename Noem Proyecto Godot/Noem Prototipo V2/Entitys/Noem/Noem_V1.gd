extends CharacterBody2D

@export var sm_acciones:Node2D
@export var data:Node

func _ready():
	add_to_group("Noem")

func _physics_process(delta):
	
	sm_acciones.action_of_active_state()

	move_and_slide()
