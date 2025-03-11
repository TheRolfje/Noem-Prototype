extends State_2D

var movimiento:Node2D
var t_distraida:Timer

func _ready():
	name_of_state = "STATE"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	t_distraida = $T_distraida
	
	movimiento = $"../../Control_of_Skills/S_Movement"
	
	_add_state_to_the_machine(name_of_state, self)

func action():
	
	movimiento.walk()
	
	pass
		



func _on_t_distraida_timeout() -> void:
	pass # Replace with function body.
