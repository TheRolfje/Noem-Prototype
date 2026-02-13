extends Node

class_name Quality

#Direcciones de los nodos que Toda Cualidad necesita para funcionar.
@export var data_path : NodePath
@export var animations_path : NodePath
@export var entity_path : NodePath
@export var SM_qualities_path : NodePath
#faltaría sonido y demás.
#------------------------------------------------------

#Nodos que Toda Cualidad necesita para funcionar.
@onready var data : Node = null
@onready var animations : Node = null
@onready var entity : Node = null
@onready var SM_qualities : Qualities_Manager = null
#------------------------------------------------------

@onready var active_sub_quality : Node2D = null

#Datos de la Cualidad:
@onready var name_of_quality : StringName = "NONE"

#Estados y Cualidades desde los que esta Cualidad no puede activarse.
@onready var estados_locomocionales_bloqueados : Array = []
@onready var estados_de_proteccion_bloqueados : Array = []
@onready var estados_fisicos_bloqueados : Array = []
@onready var estados_emocionales_bloqueados : Array = []
@onready var cualidades_bloqueadas : Array = []

func _ready() -> void: #Hace falta llamar a este _ready en TODAS LAS CUALIDADES.
	_asignar_dependencias()
	_add_quality_to_the_machine() #Añade la cualidad a la SM de cualidades.
		
func _add_quality_to_the_machine():
	SM_qualities.add_new_state_to_dictionary(name_of_quality, self)

func _asignar_dependencias():
	data = _buscar_nodo_por_su_direccion(data_path, "DATA")
	entity = _buscar_nodo_por_su_direccion(entity_path, "ENTITY")
	animations = _buscar_nodo_por_su_direccion(animations_path, "ANIMATIONS")
	SM_qualities = _buscar_nodo_por_su_direccion(SM_qualities_path, "SM_QUALITIES")
	
func _buscar_nodo_por_su_direccion(path : NodePath, nombre_de_dependencia : String):
	if path.is_empty():
		push_error("Error, nodo '%s' no conectado" % nombre_de_dependencia)
		return null
	
	var nodo := get_node_or_null(path) #Busca el nodo por su dirección
	
	if nodo == null:
		push_error("No se encontró el nodo '%s' en: %s" % [name, path])
		
	return nodo
	
func _initialize_quality(): #La SM inicia la Cualidad con este método.
	quality_start_action() #Primero se ejecuta la acción de inicio de la Cualidad.
	choose_sub_quality() #Después se elije e inica una Sub Cualidad.

#Las Cualidades Sobreescriben estos métodos:
func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	pass
#------------------------------------------------------
	
func _sub_quality_action(): #La SM ejecuta esto en bucle.
	active_sub_quality.action()
	
func end_quality(): #Lo ejecuta la SM cuando cambia la Cualidad, para terminar con la actual.
	active_sub_quality = null #Siempre debe ejecutarse cuando una Cualidad Cambia.
	
	quality_end_action() #Este es el método que las Cualidades sobreescriben.
	
func _start_this_sub_quality(new_sub_quality: String):
	#Cierra la SubCualidad anterior y ejecuta la acción de inicio de una nueva.
	
	if active_sub_quality: #Si es Null acá es porque es la primera SC que esta C eligió.
		if active_sub_quality.has_method("end_action"):
			active_sub_quality.end_action() #Si no es Null, primero termina la SC activa.
		else:
			push_warning("La SubCualidad no tiene método End_Action")
	active_sub_quality = get_node_or_null(new_sub_quality)
	
	if active_sub_quality:
		if active_sub_quality.has_method("start_action"):
			active_sub_quality.start_action()
		else:
			push_warning("La SubCualidad no tiene método Start_Action")
			
		if not active_sub_quality.has_method("action"):
			push_warning("La SubCualidad no tiene método Action")
			#Lo valiodo aca porque si no se validaría en bucle por la SM.
	else:
		push_warning("La SubCualidad no se encontró.")
