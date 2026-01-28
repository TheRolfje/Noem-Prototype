extends Node

#Se encarga de todo lo referente a entradas de teclado.

@export var data:data_humanoid
@export var state_machine:State_Machine

var estados_sin_transicion:Array = ["RUN", "WALK_APUNTANDO", "STEALTH"]

func _process(delta: float) -> void:
	
	if(data.teclado_on):
		
		data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
		
		if(data.direction_look.x == data.direction_movement.x * -1 and
		!estados_sin_transicion.has(state_machine.active_state.name_of_state)):
			state_machine._switch_state("TRANSITION")
		
		else:
			if(Input.is_action_pressed("support_yourself")):
				data.sostenerse = true
			else:
				data.sostenerse = false
				
			if(Input.is_action_pressed("ui_up")):
				data.action_pressed = true
			else:
				data.action_pressed = false
				
			if(Input.is_action_pressed("Stealth")):
				data.stealth = true
			else:
				data.stealth = false
