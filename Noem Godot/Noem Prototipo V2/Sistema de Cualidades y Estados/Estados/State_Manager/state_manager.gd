extends Node

#Cosas que faltan:

#Todas las entidades tienen más o menos los mismos posibles estados, por ende
#podría haber una o varias clases que los tengan por separados por tipo. Dichas
#clases o nodos pertenecen a una escena State_Manager por defecto, que todas
#las entidades cargan en sus árboles de nodos.
#En cuanto a las reglas o efectos que los estados tienen sobre todas las Entidades,
#lo ideal sería que el estado activo determina una lista de reglas que
#la Entidad en ese estado debe seguir, y una lista de efectos que se cargan a
#la Entidad, pero es la propia Entidad la encargada de gestionar como le afecta.
#El State Manager debería poder soportar que una Entidad le diga "Yo no sigo
#esa regla", y simplemente no le envié las señales o ejecute los métodos de esa
#regla cuando la Entidad pida que no se haga. Lo mismo para los efectos:
#Una entidad inmune al fuego podría "incendiarse y que no le afecte", pero a nivel
#de procesamiento es más sencillo marcar una casilla que diga "A mi no me mandes
#esto porque, o no me afecta, o tiene efectos/reglas distintas en mí", y ahí
#la propia Entidad es responsable de gestionarlo. 

#-------------------------------------------------------

class_name  State_Manager

@export var data_entity : data_humanoid
@export var qualities_manager : Qualities_Manager

#Este diccionario guarda los diccionarios que contienen cada estado,
#separados por tipo
var _all_states_in_the_manager : Dictionary[StringName, Dictionary] = {
	State_Type.LOCOMOTIONAL : {},
	State_Type.EMOTIONAL : {},
	State_Type.PHYSICAL : {},
	State_Type.PROTECTION : {}
}

#Guarda los estados activos. Como solo hay un estado activo por tipo, el
#tipo es la clave del diccionario.
var _active_states : Dictionary[StringName, State] = {
	State_Type.LOCOMOTIONAL : null,
	State_Type.EMOTIONAL : null,
	State_Type.PHYSICAL : null,
	State_Type.PROTECTION : null
}

var _label_old_states : Dictionary[StringName, StringName] = {
	State_Type.LOCOMOTIONAL : &"",
	State_Type.EMOTIONAL : &"",
	State_Type.PHYSICAL : &"",
	State_Type.PROTECTION : &""
}
#Estados que terminaron su "action_of_end"
#Estan en True por defecto porque originalmente no hay estados que cerrar,
#ya después cuando empiezan a llegar nuevos estados esto siempre queda en
#false por defecto.
var _old_states_finished : Dictionary[StringName, bool] = {
	State_Type.LOCOMOTIONAL : true,
	State_Type.EMOTIONAL : true,
	State_Type.PHYSICAL : true,
	State_Type.PROTECTION : true
}
#Estados que terminaron su "action_of_start"
var _new_states_initialized : Dictionary[StringName, bool] = {
	State_Type.LOCOMOTIONAL : false,
	State_Type.EMOTIONAL : false,
	State_Type.PHYSICAL : false,
	State_Type.PROTECTION : false
}
#Ambos se guardan porque si o si todos los estados deben haber terminado sus acciones
#de inicio y fin para que las acciones en bucle de los estados puedan empezar a ejecutarse.
#Por eso, la variable de abajo se pone en true si todo está en orden para ejecutar
#la acción en bucle de los estados.
var _states_ready_to_execute : Dictionary[StringName, bool] = {
	State_Type.LOCOMOTIONAL : false,
	State_Type.EMOTIONAL : false,
	State_Type.PHYSICAL : false,
	State_Type.PROTECTION : false
}
	
func add_state_to_manager(new_state : State, name_of_state : StringName, type : StringName):
	var dictionary_of_state : Dictionary = _all_states_in_the_manager[type]
	
	dictionary_of_state[name_of_state] = new_state

#Esta función se llama desde fuera con una señal.
func change_active_state(new_state : StringName, type : StringName):
	
	_states_ready_to_execute[type] = false
	
	if(_active_states[type] != null):
		#Si no había un estado activo de ese tipo, significa que este que llega
		#es el primero, por ende no hay ningun "estado que cerrar".
		await close_old_state(type)
		
		_label_old_states[type] = _active_states[type].name_of_state
	else:
		_label_old_states[type] = new_state
		
	assing_new_active_state(new_state, type)
	
	await initialized_new_state(type)
	
	data_entity.change_state_labels(new_state, type)
	notify_quality_manager_about_type_of_state_changed(type)
	
func close_old_state(type : StringName):
	_old_states_finished[type] = false
	await _active_states[type].action_of_end()
	_old_states_finished[type] = true
		
func assing_new_active_state(new_state : StringName, type : StringName):
	var dictionary_of_states : Dictionary = _all_states_in_the_manager[type]
	
	var state = dictionary_of_states[new_state]
	
	_active_states[type] = state
		
func initialized_new_state(type : StringName):
	_new_states_initialized[type] = false
	await _active_states[type].action_of_start()
	_new_states_initialized[type] = true

func notify_quality_manager_about_type_of_state_changed(type : StringName):
	qualities_manager.evaluate_sub_quality_selection_according_to_state_changed(type)
	
func action_of_active_states(): #El physics procces de la entidad ejecuta esto en bucle.
	verify_and_excute_state_of_type(State_Type.LOCOMOTIONAL)
	verify_and_excute_state_of_type(State_Type.PROTECTION)
	verify_and_excute_state_of_type(State_Type.PHYSICAL)
	verify_and_excute_state_of_type(State_Type.EMOTIONAL)
		
func verify_and_excute_state_of_type(type):
	if (_states_ready_to_execute[type]): 
		_active_states[type].action()
	else:
		_check_state_of_this_type(type)
	
func _check_state_of_this_type(type):
	if(
		_state_type_have_a_active_state(type) and
		_old_state_of_typeX_finished(type) and 
		_active_states_of_typeX_initialized(type)
	):
		_states_ready_to_execute[type] = true
		
					
func _state_type_have_a_active_state(type):
	return _active_states[type] != null

func _active_states_of_typeX_initialized(type):
	#la función "initialized_new_state" hace esto.
	return _new_states_initialized[type] == true

func _old_state_of_typeX_finished(type):
	#la función "close_old_state" hace esto.
	return _old_states_finished[type] == true
