extends State_2D

@export var movimiento:movement_skills

func _ready():
	name_of_state = "RUN"
	state_machine = $".."
	entity = state_machine.Entity
	data = state_machine.Data
	animations = state_machine.Animations


	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	_flip_sprite_according_to_direction()
	
	animations.play("Run")
		
	movimiento.run()
		
