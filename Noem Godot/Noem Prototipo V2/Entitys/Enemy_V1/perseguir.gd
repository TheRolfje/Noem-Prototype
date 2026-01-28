extends State_2D

@export var sm_acciones:State_Machine

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "PERSEGUIR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	travel_to_state.connect(sm_acciones.new_state_signal)

	_add_state_to_the_machine(name_of_state, self)

func action():
	data.set_direction_move_x(sign(data.jugador.global_position.x - entity.global_position.x))
			
	emit_signal("travel_to_state", "RUN")
		
