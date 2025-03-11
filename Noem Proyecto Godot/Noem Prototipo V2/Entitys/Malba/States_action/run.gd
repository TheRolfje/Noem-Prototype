extends State_2D

var movimiento:Node2D

func _ready():
	name_of_state = "RUN"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	movimiento = $"../../Control_of_Skills/S_Movement"

	_add_state_to_the_machine(name_of_state, self)

func action():
	movimiento.run()
		
