extends State_2D

@export var sm_acciones:State_Machine
var t_walk:Timer

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "PATRULLAR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	t_walk = $Timer
	
	travel_to_state.connect(sm_acciones.new_state_signal)
	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)
	
	state_machine.assign_default_state(self)

func action():
	if(sm_acciones.active_state.name_of_state != "WALK"):
		emit_signal("travel_to_state", "WALK")
	
	if(t_walk.is_stopped()):
		t_walk.start()
		
func action_of_end():
	t_walk.stop()

func _on_timer_timeout() -> void:
	data.set_direction_move_x(data.direction_movement.x * -1)
