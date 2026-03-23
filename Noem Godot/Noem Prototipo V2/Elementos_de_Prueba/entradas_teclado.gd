extends Node

@export var quality_manager : Qualities_Manager
@export var state_manager : State_Manager

signal change_active_quality(new_quality : StringName)
signal change_this_type_of_active_state(new_state : StringName, type_state : StringName)

func _ready() -> void:
	change_active_quality.connect(quality_manager.change_active_quality)
	change_this_type_of_active_state.connect(state_manager.change_active_state)

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Stealth")):
		print("\nCambiar a Estado B")
		change_this_type_of_active_state.emit(&"l_state_b", State_Type.LOCOMOTIONAL)
	
	if (Input.is_action_just_pressed("shift")):
		print("\nCambiar a Estado A")
		change_this_type_of_active_state.emit(&"l_state_a", State_Type.LOCOMOTIONAL)
	
	if (Input.is_action_just_pressed("support_yourself")):
		print("\nCambiar a Qualidad B")
		change_active_quality.emit(&"Quality_B")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		print("\nCambiar a Qualidad A")
		change_active_quality.emit(&"Quality_A")
