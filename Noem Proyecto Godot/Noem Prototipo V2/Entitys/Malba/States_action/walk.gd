extends State_2D

var movimiento:Node2D
var t_distraida:Timer

func _ready():
	name_of_state = "WALK"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	t_distraida = $T_distraida
	
	movimiento = $"../../Control_of_Skills/S_Movement"
	
	_add_state_to_the_machine(name_of_state, self)

func action():
	
	movimiento.walk()
	
	if(t_distraida.is_stopped()):
		t_distraida.start()
	
	if(data.distraida):
		data.direccion_distraida = data.direction_movement.x
		state_machine._switch_state("DISTRAIDA")
	
		

func action_of_end():
	t_distraida.stop()


func _on_t_distraida_timeout() -> void:
	data.distraida = true
