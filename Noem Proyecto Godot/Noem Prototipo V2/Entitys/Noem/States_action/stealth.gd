extends State_2D

func _ready():
	name_of_state = "STEALTH"
	state_machine = $".."
	entity = state_machine.Entity

	states_to_which_I_can_travel = ["IDLE", "RUN", "WALK", "A"]
	states_that_can_travel_to_me = ["IDLE", "RUN", "WALK", "A"]

	_add_state_to_the_machine(name_of_state, self)

func action():
	print("Estoy en STEALTH")
		
