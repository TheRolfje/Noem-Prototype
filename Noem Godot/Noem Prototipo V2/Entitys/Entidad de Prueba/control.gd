extends Node

#Función:
#Se encarga de tomar las señales del nodo de Entrada de Teclado y en base al contexto de la Entidad
#(determinado mayormente por el nodo Data), enviar las señales que activan las Cualiades deseadas.

class_name Control_Player

@export var data : data_humanoid
@export var buffer : buffer_actions

@onready var buffer_permisos : buffer_coyote_time = $"../buffer_coyote_time"
@onready var teclado : entradas_teclado = $"../Entradas Teclado"
@onready var quality_manager : Qualities_Manager = $"../Qualities_Manager"

var action_validators : Dictionary [StringName, Callable]

func _ready() -> void:
	action_validators["agacharse"] = validator_agacharse
	action_validators["levantarse"] = validator_levantarse

func _process(delta: float) -> void:
	
	if data.action_one_use_in_course == false: #Las acciones continuas se pausan hasta que las de Un Uso terminen.
		excecute_continuos_quality()
		
	execute_last_one_shot_action(buffer.last_action)


func excecute_continuos_quality(): #Acciones continuas. Dependen de cuando quiere la Entidad que duren.
	if(data.corriendo and data.direction_movement.x != 0 and data.active_quality != "derrapar"):
		excecute("run")
	
	elif (data.direction_movement.x != 0 and data.active_quality != "derrapar"):
		excecute("walk")
	elif (data.active_quality != "derrapar"):
		excecute("idle")

func execute_last_one_shot_action(last_action : StringName):
	if(last_action == &"none"): #Si no es "none" significa que hay una last_action activa
		return
		
	if(not buffer.action_with_life(last_action)): #Pregunta si la acción sigue con vida en el buffer.
		return
		
	if(action_validators.has(last_action)): #Pregunta si la acción tiene un validador. Si no lo tiene no lo necesita.
		if(not action_validators[last_action].call()): #Pregunta al Validador de la acción si la acción se puede ejecutar.
			return
	
	if(excecute(last_action)): #Si paso todas las pruebas, ejecuta la acción.
		buffer.consume_action(last_action)
		
func validator_agacharse() -> bool:
	return (not data.agachado)
	
func validator_levantarse() -> bool:
	return (data.agachado)
	
#Obviamente a estos métodos le falta complegidad sobre que hacer con Shift y Ctrl en los diferentes
#Estados de la Entidad o Intenciones del jugador.
#Estas dos son especiales porque inician acciones continuas de forma indirecta: Correr y Estar Agachado.
func shift_on():
	data.corriendo = true
	data.derrape_permitido = true
	
func shift_off():
	data.corriendo = false
	data.derrape_permitido = false
	buffer_permisos.add_permission("derrapar_permitido")
	
func ctrl_on():
	if(data.derrape_permitido or buffer_permisos.permission_with_life("derrapar_permitido")):
		buffer.add_action("derrapar")
		return 
	
	buffer.add_action("agacharse")
	
func ctrl_off():
	buffer.add_action("wake_up")
	
func contener():
	pass
#---------------------------------------------------------

func excecute(action : StringName):
	return quality_manager.change_active_quality(action)
