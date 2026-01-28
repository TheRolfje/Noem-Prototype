extends Node2D

#Se encarga de gestionar en que estado de movimiento o general está Noem.

@export var Entity:CharacterBody2D
@export var state_machine:State_Machine
@export var data:data_humanoid
@export var animations:AnimationPlayer

signal travel_to_state(new_state:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	travel_to_state.connect(state_machine.new_state_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(data.continue_the_process):
		#print("Process ON")
		
		match state_machine.active_state.name_of_state:
			"IDLE":
				if(data.stealth):
					emit_signal("travel_to_state", "STEALTH")
				elif(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
					emit_signal("travel_to_state", "RUN")
				elif (data.direction_movement.x != 0):
					emit_signal("travel_to_state", "WALK")
					
			"WALK":
				if(data.stealth):
					emit_signal("travel_to_state", "STEALTH")
				elif(data.direction_movement.x == 0):
					emit_signal("travel_to_state", "IDLE")
				elif(Input.is_action_pressed("shift")):
					emit_signal("travel_to_state", "RUN")
			"RUN":
				if(data.direction_movement.x != 0 and not Input.is_action_pressed("shift")):
					emit_signal("travel_to_state", "WALK")
				elif(data.direction_movement.x == 0):
					emit_signal("travel_to_state", "IDLE")
			"STEALTH":
				if(!data.stealth):
					if(data.direction_movement.x != 0):
						emit_signal("travel_to_state", "WALK")
					else:
						emit_signal("travel_to_state", "IDLE")
	else:
		#print("Process OFF")
		pass
	
