extends Node2D

@export var Entity:CharacterBody2D
@export var state_machine:State_Machine
@export var data:data_humanoid

signal travel_to_state(new_state:String)

var estados_sin_transicion:Array = ["RUN"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	travel_to_state.connect(state_machine.new_state_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
	
	if(data.continue_the_process):
		if(data.direction_look.x == data.direction_movement.x * -1 and
		!estados_sin_transicion.has(state_machine.active_state.name_of_state)):
			state_machine._switch_state("TRANSITION")
		
		else:
			if(Input.is_action_pressed("support_yourself")):
				data.sostenerse = true
			else:
				data.sostenerse = false
		
			match state_machine.active_state.name_of_state:
				"IDLE":
					if(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
						emit_signal("travel_to_state", "RUN")
					elif (data.direction_movement.x != 0):
						emit_signal("travel_to_state", "WALK")
						
				"WALK":
					if(data.direction_movement.x == 0):
						emit_signal("travel_to_state", "IDLE")
					
					elif(Input.is_action_pressed("shift")):
						emit_signal("travel_to_state", "RUN")
				"RUN":
					if(data.direction_movement.x != 0 and not Input.is_action_pressed("shift")):
						emit_signal("travel_to_state", "WALK")
					elif(data.direction_movement.x == 0):
						emit_signal("travel_to_state", "IDLE")

func interruption(name_of_interruption:String):
	#la lógica es que si llega una interrupción, mientras ese estado este activo solo se procesa
	#la lógica de ese estado y se ignora todo lo que pase en "_process". Quizás con Noem no tiene
	#tanto sentido por el Match, pero en otras entidades sí por su árbol de prioridades.
	#Mientras la interrupción esta activa, no procesas el árbol.
	
	if(state_machine.interruption_is_valid(name_of_interruption)):
		data.continue_the_process = false
		emit_signal("travel_to_state", name_of_interruption)
	
