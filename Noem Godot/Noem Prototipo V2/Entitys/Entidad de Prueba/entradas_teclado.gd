extends Node

#Función:
#Convierte las Entradas de Teclado de todo tipo, ya sean combinaciones, pulzaciones únicas o repetidas,
#en señales PRIMARIAS de acciones. Estas señales primarias no dependen del contexto del personaje del
#jugador, son solamente las señales de "Que Teclas y De Que Forma Se Pulzaron".
#Luego, las envía al Nodo de Control, quien determina que Cualidades activar en función de las entradas
#de teclado y el contexto de la Entidad, ya que una sola tecla puede hacer varias acciones, dependiendo
#del contexto.

#(Es posible que este nodo ni siquiera debería pertenecerle al personaje, ya que las teclas también
#actuan sobre menus y cosas del Juego en sí, no solo del personaje. Así que en teoría este nodo
#debería de estar corriendo SIEMPRE, independientemente de la escena. O, también, ser único del jugador
#y que otros nodos de entradas de teclado se encarguen de otras cosas como menus, etc.)

#UNA IDEA: CREAR MÉTODOS PARA EL RASTREO DE TECLAS, ME PERMITE BLOQUEARLAS INDIVIDUALMENTE.
#Acciones de teclado pulzadas (Intención de hacer algo).
	#El movimiento como tal de la Entidad se controla en Data_humanoid con "set_direction_move()"
	
	#Las variables "continuous" indican si la acción continua o no al mantener pulzada la tecla.
	#Si está en false, la acción no continua y se entiende que el jugador debe mantener apretado.
	#Por defecto estan en True, por el tipo de jugabilidad que espero para Noem. La idea es que sean
	#configurables desde el menu.

#------------------------------------------------------

class_name entradas_teclado

@onready var control_node : Control_Player = $"../Control"
@export var data : data_humanoid

var toggle_actions : Dictionary[StringName, bool] = {}

@export var ctrl_continuos : bool = true
@export var shift_continuos : bool = true

#-------------------------------------------------------

func _process(delta: float) -> void:
	
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right")) #Determino el movimiento que tiene la Entidad.
	
	#De base se usan para iniciar/frenar acciones continuas de forma indirecta.
	detect_shift_action()
	detect_ctrl_action()
	
#PODRÍAN HACERSE CON SEÑALES GENERALES Y QUE OTROS NODOS SE SUBSCRIBAN, SI LO LLEGO A NECESITAR.
func ctrl_on():
	control_node.ctrl_on()
	
func ctrl_off():
	control_node.ctrl_off()
	
func shift_on():
	control_node.shift_on()
	
func shift_off():
	control_node.shift_off()
	
func detect_shift_action():
	manage_action("shift", shift_continuos, shift_on, shift_off)
	
func detect_ctrl_action():
	manage_action("ctrl", ctrl_continuos, ctrl_on, ctrl_off)
	
func manage_action(action : StringName, action_continuos : bool, on_metod : Callable, off_metod : Callable):
	if(action_continuos):
		if Input.is_action_just_pressed(action):
			on_metod.call()
		
		elif Input.is_action_just_released(action):
			off_metod.call()
	else:
		if Input.is_action_just_pressed(action):
			toggle_actions[action] = !toggle_actions.get(action, false)
			#toggle_actions es un diccionario que guarda si la acción de la tecla action estaba o no activa.
			#Si lo estaba, extrae true y lo convierte en false, para desactivarla, y viceversa.
			#Si la acción no existe en el diccionario también la crea, dandole por defecto True como valor,
			#ya que niega el false que retorna get() al no encontrar action como una clave.
			
			if toggle_actions[action]: #Si es true activa, si no desactiva.
				on_metod.call()
			else:
				off_metod.call()
	
