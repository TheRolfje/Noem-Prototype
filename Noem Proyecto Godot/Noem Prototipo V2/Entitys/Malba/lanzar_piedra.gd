extends State_2D

const Piedra = preload("res://Elementos_Interactuables/roca.tscn")

var lanzar:bool = true
var t_entre_lanzamientos:Timer

func _ready():
	name_of_state = "LANZAR_PIEDRA"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	t_entre_lanzamientos = $Timer
	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)
	

func action():
	if(lanzar):
		var piedra:Rock = Piedra.instantiate() 
		var direccion_lanzamiento:Vector2 = _calcular_lanzamiento()
		get_parent().add_child(piedra)
		
		piedra.lanzar(entity.global_position, data.objetivo_atacado.global_position)
		lanzar = false
		if(t_entre_lanzamientos.is_stopped()):
			t_entre_lanzamientos.start(1)
	
		

func _calcular_lanzamiento():
	var direccion:Vector2
	
	direccion = Vector2(300, -300)
	
	return direccion

func action_of_end():
	#Acción que se ejecuta cuando se sale del estado.
	pass


func _on_timer_timeout() -> void:
	lanzar = true
