extends State_2D

func _ready():
	name_of_state = "A"
	state_machine = $".."
	entity = state_machine.Entity

	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	print("Estoy en A")
		
