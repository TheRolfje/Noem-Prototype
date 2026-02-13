extends Node

class_name Qualities_Manager

signal request_of_change_of_state
signal state_changed

var active_state:Quality
var old_state:Quality

var new_state_initiated:bool = true
var active_state_finished:bool = true

var check_if_the_quality_is_valid:bool = false
#Si se pone en true, la S.M. pregunta si la cualidad es valida para los estados
#y la cualidad activa. Si todo esta bien se cambia, si no se ignora. Se usa principalmente
#para el jugador. Los NPCs validan estas cosas por IA normalmente.
#Si está en false, la Cualidad solo se cambia y ya.

var States_in_the_Machine:Dictionary = {}

var States_whit_pending_connections:Array = [] #Funciona cuando los estados se van agregando a la SM, solo si se quiere.
	
func interruption_is_valid(name_of_interruption:String):
	if(active_state.name_of_state != name_of_interruption):
		if(!name_of_interruption in active_state.interruptions_not_allowed):
			return true
		else:
			return false
	else:
		return false
	
func new_state_signal(name_of_quality:String): #Cambiar nombre
	#Recibe una señal desde fuera con el nombre del estado al que se quiere cambiar.
	if(active_state.name_of_quality != name_of_quality):
		#print("Recibi una señal: ", name_of_quality)
		if(check_if_the_quality_is_valid):
			if(verificar_si_la_cualidad_puede_activarse(name_of_quality)):
				#print("La señal es valida ", name_of_quality)
				#Si el nombre es valido, se cambia el estado. Si no, solo se ignora.
				_switch_state(name_of_quality)
			#else:
				#print("Estado no disponible en: ", active_state.name_of_quality)
		else:
			_switch_state(name_of_quality)
		
func verificar_si_la_cualidad_puede_activarse(name_of_quality : String):
	#No se me ocurrió otro nombre. Entra a las listas de estados y Cualidades bloqueados
	#de la cualidad que quiere activarse. Si los estados activos o la cualidad activa
	#no aparecen en esas listas, entonces la nueva Cualidad no tiene problema con esos
	#estados y puede cambiarse.
	pass
	
func _switch_state(name_of_new_active_state:String):
	#Registra el estado activo como old_state y luego busca la clave del nuevo
	#estado en el diccionario para asignarlo como estado activo.
	if(States_in_the_Machine.has(name_of_new_active_state)):
		request_of_change_of_state.emit() #Es para uso externo.
		
		await action_end_of_active_state()
		active_state_finished = true
		
		old_state = active_state
		active_state = States_in_the_Machine[name_of_new_active_state]
		
		state_changed.emit() #Tambien uso externo.
		
		await action_start_of_active_state()
		new_state_initiated = true
		#print("Estado cambiado de ", old_state.name_of_state, " a: ", active_state.name_of_state)
	else:
		push_error("El estado: ", name_of_new_active_state, " no fue creado o añadido a la StateMachine")
		
func add_new_state_to_dictionary(name_new_state:String, new_state:Quality):
	#Agrega un estado nuevo al diccionario de la State Machine.
	if(!States_in_the_Machine.has(name_new_state)):
		States_in_the_Machine[name_new_state] = new_state
		
		#Antes de añadir el nuevo estado a la red, primero reinta añadir estados con conecciones
		#pendientes, ya que gracias a la nueva inclusión en el diccionario ahora quizá si se pueda.
		if(!States_whit_pending_connections.is_empty()):
			for state_pending in States_whit_pending_connections:
				_add_new_state_to_network_of_states(States_in_the_Machine[state_pending])
	
		#Ahora añade el nuevo estado a la red.
		#_add_new_state_to_network_of_states(new_state)
	else:
		assert(name_new_state , " Ya está en la State Machine. Se está intento añadir un duplicado")
	
func _add_new_state_to_network_of_states(new_state:State_2D): #Modificar para Cualidades.
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
				#Si no existe en el diccionario de pendientes, lo agrega.
				
	if(!ingreso_a_pendientes and States_whit_pending_connections.has(new_state.name_of_state)):
		#Si estaba en la lista de pendientes, pero no volvió a ingresar significa que pudo hacer todas
		#sus conecciones, por lo que ya no tiene pendientes. Por eso se saca de dicha lista.
		States_whit_pending_connections.erase(new_state.name_of_state)
	
func action_of_active_state():
	#Ejecuta la acción del estado activo.
	if(active_state_finished and new_state_initiated):
		active_state.action()
	
func action_end_of_active_state():
	active_state_finished = false
	await active_state.action_of_end()
	
func action_start_of_active_state():
	new_state_initiated = false
	await active_state.action_of_start()

func assign_default_state(state:Quality):
	#Asigna un estado como estado por default de la entidad. Normalmente IDLE.
	active_state = state
	old_state = active_state
