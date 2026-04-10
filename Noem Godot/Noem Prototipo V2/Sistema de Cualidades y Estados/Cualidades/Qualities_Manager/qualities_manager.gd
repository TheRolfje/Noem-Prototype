extends Node

class_name Qualities_Manager

#Son notificadores para uso externo
signal request_of_change_of_quality
signal quality_changed
#-----------------------------------

@export var entity : Entity
@export var data_entity : data_humanoid
@export var animations : AnimationPlayer
#falta nodos de control, sonido, etc.

var active_quality: Quality
var default_quality: Quality
var old_active_quality:StringName

#Solo se ejecuta la acción de la Cualidad (o la busqueda de subcualidades)
#si estos estan en true
var new_quality_initialized:bool = false
var old_active_quality_finished:bool = true
#---------------------------------------------

#Si se pone en true, la S.M. pregunta si la cualidad es valida para los estados
#y la cualidad activa. Si todo esta bien se cambia, si no, se ignora. Se usa principalmente
#para el jugador. Los NPCs validan estas cosas por IA normalmente.
#Si está en false, la Cualidad solo se cambia y ya.
@export var check_if_the_quality_is_valid:bool = false
#-----------------------------------------------------

var all_qualities_in_the_manager:Dictionary[StringName, Quality]
	
func change_to_default_quality():
	#print("Solicitud de Uso de Cualidad Default: " + default_quality.name_of_quality + "\n")
	change_active_quality(default_quality.name_of_quality)
	
func change_active_quality(name_of_quality:StringName) -> bool:
	#Recibe una señal desde fuera con el nombre de la cualidad a la que se quiere cambiar.
	if all_qualities_in_the_manager.has(name_of_quality):
		if(active_quality == null or name_of_quality != active_quality.name_of_quality):
			print("Solicitud de cambio a Cualidad: " + name_of_quality + "\n")
			if(check_if_the_quality_is_valid):
				if(verificar_si_la_cualidad_puede_activarse(name_of_quality)):
					_switch_quality(name_of_quality)
					print("Cualidad: " + name_of_quality + " cambiada con exito\n")
					return true
				else:
					return false
			else:
				_switch_quality(name_of_quality)
				#print("Cualidad: " + name_of_quality + " cambiada con exito\n")
				return true
		else:
			return false
	else:
		push_error("CUALIDAD NO ENCONTRADA EN EL QUALITIES MANAGER")
		return false

func determine_if_Active_Quality_is_affected_by_this_state_change(type : StringName):
	#Si un estado activo cambió, se evalúa si ese cambio le importa o no a la
	#Cualidad activa, para saber si es necesario procesarlo y reelegir una SubCualidad
	match type:
		State_Type.LOCOMOTIONAL:
			if(active_quality.lomocomotional_changes_affect_me):
				active_quality.init_choose_sub_quality()
		State_Type.EMOTIONAL:
			if(active_quality.emotional_changes_affect_me):
				active_quality.init_choose_sub_quality()
		State_Type.PHYSICAL:
			if(active_quality.physical_changes_affect_me):
				active_quality.init_choose_sub_quality()
		State_Type.PROTECTION:
			if(active_quality.protection_changes_affect_me):
				active_quality.init_choose_sub_quality()
		State_Type.STEALTH:
			if(active_quality.stealth_changes_affect_me):
				active_quality.init_choose_sub_quality()
		
func _switch_quality(name_of_new_active_quality:StringName):
	#Registra la cualidad activa como old_active_quality y luego busca la clave de la nueva
	#cualidad en el diccionario para asignarla como cualidada activa.
	
	#print("Cambiando a Cualidad: " + name_of_new_active_quality + "\n")
		
	if(all_qualities_in_the_manager.has(name_of_new_active_quality)):
		request_of_change_of_quality.emit() #Es para uso externo.
		
		if(active_quality != null and active_quality.active_sub_quality != null):
			await action_end_of_active_quality()
	
			old_active_quality = active_quality.name_of_quality	
		else:
			old_active_quality = name_of_new_active_quality
			
		active_quality = all_qualities_in_the_manager[name_of_new_active_quality]
		data_entity.active_quality = active_quality.name_of_quality
			
		quality_changed.emit() #Tambien uso externo.
			
		await action_start_of_active_quality()
	else:
		push_error("La Cualidad: ", name_of_new_active_quality, " no fue creada o añadida a la Quality Manager")
	
func execute_sub_quality(quality_owner : StringName, sub_quality : StringName):
	#Ejecuta una subCualidad directamente. Pensado para interrupciones.
	var quality : Quality = all_qualities_in_the_manager[quality_owner]
	
	quality._start_this_sub_quality(sub_quality)

func add_new_quality_to_dictionary(name_new_quality:StringName, new_quality:Quality):
	if(name_new_quality != &"none"):
		if(!all_qualities_in_the_manager.has(name_new_quality)):
			all_qualities_in_the_manager[name_new_quality] = new_quality
	else:
		push_error("LA CUALIDAD NO TIENE NOMBRE, SE LE DEBE PONER NOMBRE ANTES DE LLAMAR A ESTE METODO.")
	
func action_of_active_SUB_quality(): #El physics process de la Entidad ejecuta esto en bucle.
	if(old_active_quality_finished and new_quality_initialized and active_quality.new_sub_quality_initialized):
		active_quality._sub_quality_action()
		
		if(active_quality.one_use_quality):
			action_end_of_active_quality()
	
func action_end_of_active_quality():
	old_active_quality_finished = false
	await active_quality.finish_quality()
	old_active_quality_finished = true
	
	if (active_quality.one_use_quality):
		data_entity.action_one_use_in_course = false
	
	new_quality_initialized = false #Como la Cualidad Activa termino, no hay ninguna activa ni
	#inicializandose, por ende se debe esperar a que "action start" marque una Nueva Cualidad como
	#inicializada.

func action_start_of_active_quality():
	await active_quality.initialize_quality()
	new_quality_initialized = true

func assign_this_quality_ass_default_quality(quality:Quality):
	default_quality = quality

func verificar_si_la_cualidad_puede_activarse(name_of_quality : StringName):
	#No se me ocurrió otro nombre. La Cualidad que quiere activarse tiene una lista
	#de Estados y Cualidades bloqueados, desde los cuales no se puede activar.
	#Si los estados activos o la cualidad activa no aparecen en esas listas,
	#entonces la nueva Cualidad no tiene problema y puede cambiarse.

	var quality : Quality = all_qualities_in_the_manager[name_of_quality]
	
	if(
		_no_problem_with_active_quality(quality) and
		_no_problem_with_active_emotional_state(quality) and
		_no_problem_with_active_locomotional_state(quality) and 
		_no_problem_with_active_physical_state(quality) and
		_no_problem_with_active_protection_state(quality)
	):
		return true
	else:
		return false
	
func _no_problem_with_active_quality(quality : Quality):
	if(not quality.cualidades_bloqueadas.has(data_entity.active_quality)):
		return true
		
	print("La Cualidad Activa: " + active_quality.name_of_quality + " No permite el cambio a : " + str(quality.name_of_quality))
		
func _no_problem_with_active_locomotional_state(quality : Quality):
	if(not quality.estados_locomocionales_bloqueados.has(data_entity.active_locomotional_state)):
		return true
		
func _no_problem_with_active_emotional_state(quality : Quality):
	if(not quality.estados_emocionales_bloqueados.has(data_entity.active_emotional_state)):
		return true
		
func _no_problem_with_active_protection_state(quality : Quality):
	if(not quality.estados_de_proteccion_bloqueados.has(data_entity.active_protection_state)):
		return true

func _no_problem_with_active_physical_state(quality : Quality):
	if(not quality.estados_fisicos_bloqueados.has(data_entity.active_physical_state)):
		return true
		
func interruption_is_valid(name_of_interruption:String):
	if(active_quality.name_of_quality != name_of_interruption):
		if(!name_of_interruption in active_quality.interruptions_not_allowed):
			return true
		else:
			return false
	else:
		return false
