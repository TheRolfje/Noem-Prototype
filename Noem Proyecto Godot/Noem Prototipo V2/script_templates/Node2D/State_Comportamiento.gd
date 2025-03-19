extends State_2D

@export var sm_acciones:Node2D

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "STATE"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations

	
	travel_to_state.connect(sm_acciones.new_state_signal)
	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	#Acción del estado:
	pass
		

func action_of_end():
	#Acción que se ejecuta cuando se sale del estado.
	pass
