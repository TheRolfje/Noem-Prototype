extends State_2D

@export var walk_speed_distraida:float
var velocidad_original:float

var movimiento:Node2D

var t_distraida:Timer

func _ready():
	name_of_state = "DISTRAIDA"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	t_distraida = $Timer
	movimiento = $"../../Control_of_Skills/S_Movement"
	
	velocidad_original = data.walk_speed

	_add_state_to_the_machine(name_of_state, self)

func action():
	data.set_direction_move_x(data.direccion_distraida)
	data.walk_speed = walk_speed_distraida
	
	if(t_distraida.is_stopped()):
		t_distraida.start(2)
	
	movimiento.walk()
	
	if(!data.distraida):
		state_machine._switch_state(state_machine.old_state)
		
		
func action_of_end():
	data.walk_speed = velocidad_original

func _on_timer_timeout() -> void:
	data.distraida = false
