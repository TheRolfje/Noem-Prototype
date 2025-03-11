extends State_2D

@export var movimiento:Node2D

var direccion_distraida:int
var distancia_hasta_noem:int
var direccion_hacia_noem:int

var sm_acciones:Node2D

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "SEGUIR_A_NOEM"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	sm_acciones = $"../../S_M_Acciones"
	
	travel_to_state.connect(sm_acciones.new_state_signal)
	

	_add_state_to_the_machine(name_of_state, self)

func action():
	distancia_hasta_noem = abs(data.noem.global_position.x - entity.global_position.x)
	direccion_hacia_noem
	
	if(data.noem.global_position.x - entity.global_position.x < 0):
		direccion_hacia_noem = -1
	else:
		direccion_hacia_noem = 1
		
	data.set_direction_move_x(direccion_hacia_noem)
	
	
	if(distancia_hasta_noem > data.distancia_de_seguimiento_max):
		if(sm_acciones.active_state.name_of_state != "DISTRAIDA"):
			emit_signal("travel_to_state", "RUN")
	elif(distancia_hasta_noem < data.distancia_de_seguimiento_min):
		if(sm_acciones.active_state.name_of_state != "DISTRAIDA"):
			emit_signal("travel_to_state", "IDLE")
	else:
		emit_signal("travel_to_state", "WALK")
	
