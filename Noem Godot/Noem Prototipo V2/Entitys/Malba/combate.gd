extends State_2D

@export var sm_acciones:Node2D

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "COMBAT"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	travel_to_state.connect(sm_acciones.new_state_signal)
	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	emit_signal("travel_to_state", "LANZAR_PIEDRA")
		

func action_of_end():
	#Acción que se ejecuta cuando se sale del estado.
	pass
