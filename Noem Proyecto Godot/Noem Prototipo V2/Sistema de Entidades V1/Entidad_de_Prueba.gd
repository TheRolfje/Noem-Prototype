extends CharacterBody2D

@export var state_machine:Node2D
@export var data:Node

func _ready():
	add_to_group("Noem")

func _physics_process(delta):
	
	state_machine.action_of_active_state()

	move_and_slide()
