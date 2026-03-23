extends CharacterBody2D

@export var quality_manager : Qualities_Manager
@export var state_manager : State_Manager

signal change_active_quality(new_quality : StringName)
signal change_this_type_of_active_state(new_state : StringName, type_state : StringName)

func _ready() -> void:
	add_to_group("Humanoid_Entity")
	
	change_active_quality.connect(quality_manager.change_active_quality)
	change_this_type_of_active_state.connect(state_manager.change_active_state)
	
	#Que esto llame a un Estado Inicial o Estado Estandar. Tengo que crearlo. 
	change_this_type_of_active_state.emit(&"l_state_a", State_Type.LOCOMOTIONAL)
	quality_manager.change_to_default_quality()
	

func _physics_process(delta: float) -> void:
	
	state_manager.action_of_active_states()
	quality_manager.action_of_active_SUB_quality()

	move_and_slide()
