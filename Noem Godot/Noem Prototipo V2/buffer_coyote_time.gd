extends Node

#Misma lógica que el buffer de acciones, pero pensado para mantener vivos Permisos de activación
#durante unos ticks más.
#Su modo de uso suele ser que cuando un permiso para algo se quita, se agrega al buffer para que se
#mantenga vivo unos ticks más, como "derrapar_permitido" que se mete al buffer cuando se deja de correr
#para que el jugador pueda derrapar justo después de dejar de correr, que suele pasar.

class_name buffer_coyote_time

@export var time : int = 0 #Tiempo maximo en ticks que un permiso vive

var buffer : Dictionary[StringName, int] #Se guardan TODAS las acciones que no se pudieron ejecutar.

func add_permission(permission : StringName):
	buffer[permission] = Time.get_ticks_msec()
	
func consume_permission(permission : StringName):
	buffer.erase(permission)
	
func permission_with_life(permission : StringName):
	if not buffer.has(permission):
		return false
		
	return (Time.get_ticks_msec() - buffer[permission] <= time)
	#Si esto retorna false, significa que ya pasó el tiempo que el buffer mantiene viva a la acción.
