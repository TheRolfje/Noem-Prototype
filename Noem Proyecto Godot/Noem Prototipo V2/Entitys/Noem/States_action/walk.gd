extends State_2D

@export var movimiento:Node2D

func _ready():
	name_of_state = "WALK"
	state_machine = $".."
	entity = state_machine.Entity
	data = state_machine.Data
	
	#movimiento = state_machine.Control_Skills.get_node("Movement")

	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	#Ejecuta la animación de caminar en dependencia de la dirección del movimiento.
	data.direction_look = data.direction_movement
	
	movimiento.walk()
