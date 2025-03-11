extends State_2D

var sm_acciones:Node2D

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "ESPERANDO_NODO_NOEM"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	sm_acciones = $"../../S_M_Acciones"
	
	travel_to_state.connect(sm_acciones.new_state_signal)
	

	_add_state_to_the_machine(name_of_state, self)
	
	state_machine.assign_default_state(self)

func action():
	
	emit_signal("travel_to_state", "IDLE")
	#Reproduce la animación de Idle mientras el nodo de Noem aparece
	var noem_group = get_tree().get_nodes_in_group("Noem")  # Busca nodos en el grupo "jugador"
	if noem_group.size() > 0:
		data.noem = noem_group[0]  # Asigna la referencia al primer jugador encontrado
		
