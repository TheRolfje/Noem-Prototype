extends State_2D

func _ready():
	name_of_state = "COMBATIR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	#Acción del estado:
	pass
		
