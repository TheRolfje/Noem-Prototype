extends Node

#Todas las acciones "One Shot" de teclado entran al Buffer, y el nodo de Control las activa si las
#encuentra en el buffer. El buffer "mantiene viva" la intención del jugador de hacer una acción
#unos cuantos ticks luego de la pulzación de la tecla.
#Cuando el Nodo de Control pregunta si activar o no una acción, se fija si sigue "viva" en el buffer.
#Si está viva, fue pulzada recientemente esa tecla, si no, o nunca se pulso, o se pulso hace mucho.

class_name buffer_actions

@export var buffer_time : int = 0 #Tiempo maximo en ticks que una acción "vive" en el buffer.

var buffer : Dictionary[StringName, int] #Se guardan TODAS las acciones que no se pudieron ejecutar.

var last_action : StringName = &"none" #La última acción pulsada por el jugador se ejecuta Primero por defecto.
							#Luego, el Nodo de Control decide en que orden ejecutar las demás.

func add_action(action : StringName):
	buffer[action] = Time.get_ticks_msec()
	last_action = action
	
func consume_action(action : StringName):
	buffer.erase(action)
	
	if(action == last_action):
		last_action = &"none"
	
func action_with_life(action : StringName):
	if not buffer.has(action):
		return false
		
	return (Time.get_ticks_msec() - buffer[action] <= buffer_time)
	#Si esto retorna false, significa que ya pasó el tiempo que el buffer mantiene viva a la acción.
