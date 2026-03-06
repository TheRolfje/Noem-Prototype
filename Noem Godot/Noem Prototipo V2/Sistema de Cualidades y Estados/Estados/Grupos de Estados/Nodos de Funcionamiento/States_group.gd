extends Node

class_name states_group

@export var state_manager : State_Manager

func _add_state_to_manager(new_state : State):
	state_manager.add_state_to_manager(new_state)
