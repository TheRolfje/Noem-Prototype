extends State_2D

@export var movimiento:Node2D

func _ready():
	name_of_state = "RUN"
	state_machine = $".."
	entity = state_machine.Entity
	data = state_machine.Data
	animations = state_machine.Animation_tree.get("parameters/playback")


	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	if(data.direction_look.x >= 0):
		entity.get_node("Sprite2D").scale.x = 1
	else:
		entity.get_node("Sprite2D").scale.x = -1
		
	animations.start("Run")
		
	movimiento.run()
		
