extends Entity

signal change_active_quality(new_quality : StringName)
signal change_this_type_of_active_state(new_state : StringName, type_state : StringName)

func _ready() -> void:
	add_to_group("Humanoid_Entity")
	
	change_active_quality.connect(qualities_manager.change_active_quality)
	change_this_type_of_active_state.connect(state_manager.change_active_state)
	
	#Que esto llame a un Estado Inicial o Estado Estandar. Tengo que crearlo. 
	change_this_type_of_active_state.emit(State_Names.Locomocion.FLAT_TERRAIN, State_Type.LOCOMOTIONAL)
	qualities_manager.change_to_default_quality()
	

func _physics_process(delta: float) -> void:
	
	state_manager.action_of_active_states()
	qualities_manager.action_of_active_SUB_quality()
	$Label.text = data.active_sub_quality
	$Label2.text = str(data.action_one_use_in_course)
	move_and_slide()
