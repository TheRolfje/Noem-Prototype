extends Node2D

class_name State_Machine

var active_state:State_2D #Es necesario que sea un Node2D porque se usará su metodo "Action"
var old_state:String

var check_if_the_status_is_valid:bool = false
#Si se pone en true, la S.M. pregunta si el estado es valido antes de cambiarlo.

@export var Entity:CharacterBody2D
@export var Control_Skills:Node2D
@export var Data:Data_class
@export var Animations:AnimationPlayer

var cant_of_childs:int = 0

var States_in_the_Machine:Dictionary = {}

var States_whit_pending_connections:Array = []
	
func _ready():
	#Guarda la ruta de la entidad en una variable para que los estados la usen.
	Entity = self.owner
	
func interruption_is_valid(name_of_interruption:String):
	if(active_state.name_of_state != name_of_interruption):
		if(!name_of_interruption in active_state.interruptions_not_allowed):
			return true
		else:
			return false
			
	
	
	return true
	
func new_state_signal(name_of_state:String): #Cambiar nombre
	#Recibe una señal desde fuera con el nombre del estado al que se quiere cambiar.
	if(active_state.name_of_state != name_of_state):
		#print("Recibi una señal: ", name_of_state)
		if(check_if_the_status_is_valid):
			if(name_is_valid(name_of_state)):
				#print("La señal es valida ", name_of_state)
				#Si el nombre es valido, se cambia el estado. Si no, solo se ignora.
				_switch_state(name_of_state)
			#else:
				#print("Estado no disponible en: ", active_state.name_of_state)
		else:
			_switch_state(name_of_state)
		
func name_is_valid(name_of_state:String):
	var state:Node2D
	var flag:bool = false
	
	if(active_state.states_to_which_I_can_travel.is_empty()):
		#print("La lista está vacía")
		return false
	
	if(name_of_state in active_state.states_to_which_I_can_travel):
		return true
	else:
		return false
	
func _switch_state(name_of_new_active_state:String):
	#Registra el estado activo como old_state y luego busca la clave del nuevo
	#estado en el diccionario para asignarlo como estado activo.
	if(States_in_the_Machine.has(name_of_new_active_state)):
		action_end_of_active_state()
		
		old_state = active_state.name_of_state
		active_state = States_in_the_Machine[name_of_new_active_state]
		print("Estado cambiado a: ", active_state.name_of_state)
		action_start_of_active_state()
	else:
		push_error("El estado: ", name_of_new_active_state, " no fue creado o añadido a la StateMachine")
		
func add_new_state_to_dictionary(name_new_state:String, new_state:State_2D):
	#Agrega un estado nuevo al diccionario de la State Machine.
	if(!States_in_the_Machine.has(name_new_state)):
		States_in_the_Machine[name_new_state] = new_state
		
		#Antes de añadir el nuevo estado a la red, primero reinta añadir estados con conecciones
		#pendientes, ya que gracias a la nueva inclusión en el diccionario ahora quizá si se pueda.
		if(!States_whit_pending_connections.is_empty()):
			for state in States_whit_pending_connections:
				_add_new_state_to_network_of_states(States_in_the_Machine[state])
	
		#Ahora añade el nuevo estado a la red.
		_add_new_state_to_network_of_states(new_state)
	else:
		assert(name_new_state , " Ya está en la State Machine. Se está intento añadir un duplicado")
	
func _add_new_state_to_network_of_states(new_state:State_2D):
	var ingreso_a_pendientes:bool = false
	var state:Node2D
	
	#if(new_state.states_that_can_travel_to_me.has())
	
	#Recorre toda la lista de estados que pueden viajar a "new_state"
	for name in new_state.states_that_can_travel_to_me:
		#Busca en el diccionario cada estado de la lista
		if(States_in_the_Machine.has(name)):
			state = States_in_the_Machine[name]
			if(!state.states_to_which_I_can_travel.has(new_state.name_of_state)):
				state.add_a_state_to_which_I_can_travel(new_state.name_of_state)
				#Si existe en el diccionario, añade en dicho estado a
				#"new_state" como un nuevo estado al que se puede viajar, si no estaba desde antes.
		else:
			#print("Añadí un estado pendiente: ", new_state.name_of_state)
			ingreso_a_pendientes = true
			if(!States_whit_pending_connections.has(new_state.name_of_state)):
				States_whit_pending_connections.append(new_state.name_of_state)
				#Si no existe en el diccionario, lo agrega como la lista si no estaba antes.
				
	if(!ingreso_a_pendientes and States_whit_pending_connections.has(new_state.name_of_state)):
		#Si estaba en la lista de pendientes, pero no volvió a ingresar significa que pudo hacer todas
		#sus conecciones, por lo que ya no tiene pendientes. Por eso se saca de dicha lista.
		States_whit_pending_connections.erase(new_state.name_of_state)
	
func action_of_active_state():
	#Ejecuta la acción del estado activo.
	active_state.action()
	
func action_end_of_active_state():
	active_state.action_of_end()
	
func action_start_of_active_state():
	active_state.action_of_start()

func assign_default_state(state:State_2D):
	#Asigna un estado como estado por default de la entidad. Normalmente IDLE.
	active_state = state
	old_state = active_state.name_of_state
