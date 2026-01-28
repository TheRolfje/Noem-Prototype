extends State_2D

var sm_acciones:State_Machine

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "COMBATIR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	sm_acciones = $"../../SM_acciones"
	
	travel_to_state.connect(sm_acciones.new_state_signal)
	
	_add_state_to_the_machine(name_of_state, self)

func action():
	emit_signal("travel_to_state", "ATACAR")
		
