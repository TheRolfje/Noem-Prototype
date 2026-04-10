extends Node

class_name data_humanoid

@export var entity_id:StringName = &"none"

var alive : bool = true

var attack_received : object_attack = null
var target_attack : CharacterBody2D = null

var followed_entity : CharacterBody2D = null

var direction_look:Vector2 = Vector2.RIGHT

var direction_movement:Vector2 = Vector2.RIGHT
#-----------------------------------------------------

#Acciones activas de la Entidad
#DETERMINAN LA ACCIÓN QUE UNA ENTIDAD QUIERE HACER, Y LA INTENCIÓN DE ENTRAR EN UN ESTADO
#O CUALIDAD ACTIVOS.
	#(Por ejemplo, agacharse es una acción, no necesariamente la Entidad está En Sigilo, eso lo
	#determina el entorno y la acción de agacharse en conjunto).

var agachado : bool = false
var corriendo : bool = false
var derrape_permitido : bool = false

var action_one_use_in_course : bool = false

#------------------------------------------------------

#Posibles estados de la Entidad.-----------------------
#DETERMINAN LOS ESTADOS Y LA CUALIDAD EN LA QUE REALMENTE ESTÁ LA ENTIDAD
var active_emotional_state : StringName = &"none"
var active_locomotional_state : StringName = &"none"
var active_physical_state : StringName = &"none"
var active_protection_state : StringName = &"none"
var active_stealth_state : StringName = &"none"

var active_quality : StringName = &"none"
var active_sub_quality : StringName = &"none"
#-------------------------------------------------------

#Aca se registran el estado o cualidad anterior al activado.
@onready var old_emotional_state : StringName = &""
@onready var old_locomotional_state : StringName = &""
@onready var old_physical_state : StringName = &""
@onready var old_protection_state : StringName = &""
@onready var old_stealth_state : StringName = &""

@onready var old_quality : StringName = &""
#Por defecto estan vacios para evitar errores de comparación, por las dudas.
#-------------------------------------------------------


func set_direction_move(dir:Vector2):
	direction_movement = dir
	
func set_direction_move_x(dir:int):
	direction_movement.x = dir
	
func set_direction_move_y(dir:int):
	direction_movement.y = dir

func change_state_labels(new_state : StringName, type : StringName):
	match type:
		State_Type.LOCOMOTIONAL:
			old_locomotional_state = active_locomotional_state
			active_locomotional_state = new_state
		State_Type.EMOTIONAL:
			old_emotional_state = active_emotional_state
			active_emotional_state = new_state
		State_Type.PHYSICAL:
			old_physical_state = active_physical_state
			active_physical_state = new_state
		State_Type.PROTECTION:
			old_protection_state = active_protection_state
			active_protection_state = new_state
		State_Type.STEALTH:
			old_stealth_state = active_stealth_state
			active_stealth_state = new_state
		
func chande_quality_labels(new_quality):
	old_quality = active_quality
	active_quality = new_quality


#Preguntar por Estado Locomocional Activo. "l" letra clave
func l_in_flat_terrain():
	return active_locomotional_state == State_Names.Locomocion.FLAT_TERRAIN
	
func l_in_low_slope():
	return active_locomotional_state == State_Names.Locomocion.LOW_SLOPE
#------------------------------------------------------

#Preguntar por Emoción Activa. "e" letra clave
func e_is_angry():
	return active_emotional_state == State_Names.Emocional.ENOJADO
	
func e_is_happy():
	return active_emotional_state == State_Names.Emocional.ALEGRE
	
func e_is_neutral():
	return active_emotional_state == State_Names.Emocional.NEUTRO
	
func e_is_sad():
	return active_emotional_state == State_Names.Emocional.TRISTE
	
func e_is_tenso():
	return active_emotional_state == State_Names.Emocional.TENSO
#-------------------------------------------------------

#Preguntar Estado de Sigilo Activo: "s" letra clave
func s_is_descubierto():
	return active_stealth_state == State_Names.Sigilo.DESCUBIERTO

func s_is_encubierto():
	return active_stealth_state == State_Names.Sigilo.ENCUBIERTO
	
func s_is_expuesto():
	return active_stealth_state == State_Names.Sigilo.EXPUESTO
#-------------------------------------------------------

#Preguntar Estado de Proteccion Activo: "p" letra clave
func p_is_completely_protected():
	return active_protection_state == State_Names.Proteccion.PROTECCION_COMPLETA

func p_is_just_head_protected():
	return active_protection_state == State_Names.Proteccion.SOLO_CABEZA_PROTEGIDA
	
func p_is_just_body_protected():
	return active_protection_state == State_Names.Proteccion.SOLO_CUERPO_PROTEGIDO
	
func p_is_unprotected():
	return active_protection_state == State_Names.Proteccion.DESPROTEGIDO
#-------------------------------------------------------

#Preguntar por Estado Físico: "f" letra clave
func f_is_healthy():
	return active_physical_state == State_Names.Fisico.SANO
	
func f_is_hurt():
	return active_physical_state == State_Names.Fisico.HERIDO
	
func f_is_knocked_down():
	return active_physical_state == State_Names.Fisico.DERRIBADO
	
func f_is_bleeding_out():
	return active_physical_state == State_Names.Fisico.DESANGRANDOSE
#-------------------------------------------------------
