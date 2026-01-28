extends State_2D

func _ready():
	name_of_state = "IDLE"
	state_machine = $".."
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations


	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)
	
	state_machine.assign_default_state(self)

func action():
	_flip_sprite_according_to_direction()
	
	animations.play("Idle")
	
	entity.velocity.x = 0
