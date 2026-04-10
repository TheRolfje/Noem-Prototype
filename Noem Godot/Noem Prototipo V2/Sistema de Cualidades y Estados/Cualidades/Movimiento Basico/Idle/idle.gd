extends Quality

func _ready() -> void:
	name_of_quality = "idle" #<--- Reemplazar por nombre de la Cualidad
	
	super._ready() #No Borrar ni Modificar orden de llamado.


func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	if(data_entity.active_locomotional_state == State_Names.Locomocion.FLAT_TERRAIN or
	data_entity.active_locomotional_state == State_Names.Locomocion.LOW_SLOPE):
		if(data_entity.agachado):
			_start_this_sub_quality("stealht_idle")
		else:
			_start_this_sub_quality("default_idle")

#-------------------------------------------------------

#Métodos propios de la Cualdiad.
