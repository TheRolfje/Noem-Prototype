extends Quality

#Esta Cualidad es un poco especial. Se usa para ejecutar una animación cuando la Entidad cambia de dirección.
#Se puede llamar en cualquier momento si la dirección de movimiento no coincide en la dirección en la que
#la Entidad mira, y dependiendo de la old_quiality llama a una transición u otra, siendo estas sus subcualidades.

#Esta Cualidad debería poder ser interrumpida SOLAMENTE por cualidades como Recibir un Golpe.

func _ready() -> void:
	name_of_quality = "transition_of_direction" #<--- Reemplazar por nombre de la Cualidad
	
	super._ready() #No Borrar ni Modificar orden de llamado.


func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	if(data_entity.l_in_flat_terrain()):
		_start_this_sub_quality("flat_terrain_transition")
	#_start_this_sub_quality("subquality_name") #<- Con este método activas la SubCualidad que elegiste.

#-------------------------------------------------------

#Métodos propios de la Cualdiad.
