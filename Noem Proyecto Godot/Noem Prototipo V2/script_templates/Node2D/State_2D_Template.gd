extends State_2D

func _ready():
	name_of_state = "STATE"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations

	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)
	
func action_of_start():
	#Acción que se ejecuta una única vez al inicio del estado.
	pass

func action():
	#Acción que se ejecuta continuamente mientras el estado este activo.
	pass

func action_of_end():
	#Acción que se ejecuta cuando se sale del estado.
	pass
