extends Node

class_name  State_Manager

var _locomotional_states : Dictionary[StringName, State]
var _emotional_states : Dictionary[StringName, State]
var _physical_states : Dictionary[StringName, State]
var _protection_states : Dictionary[StringName, State]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func add_state_to_manager(new_state : State, name_of_state : StringName, type : StringName):
	match type:
		State_Type.LOCOMOTIONAL:
			_locomotional_states[name_of_state] = new_state 
		State_Type.EMOTIONAL:
			_emotional_states[name_of_state] = new_state 
		State_Type.PHYSICAL:
			_physical_states[name_of_state] = new_state 
		State_Type.PROTECTION:
			_protection_states[name_of_state] = new_state 

func change_state(name_of_state : StringName, type : StringName):
	pass

func change_locomotional_state(new_state : StringName):
	pass
	
func change_physical_state(new_state : StringName):
	pass
	
func change_emociontal_state(new_state : StringName):
	pass
	
func change_protection_state(new_state : StringName):
	pass
