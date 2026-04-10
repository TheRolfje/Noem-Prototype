extends Quality

func _ready() -> void:
	name_of_quality = "run" #<--- Reemplazar por nombre de la Cualidad
	
	super._ready() #No Borrar ni Modificar orden de llamado.


func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	if(data_entity.l_in_flat_terrain() or data_entity.l_in_low_slope()): #CREAR CASO ESPECIFICO PARA LOW_SLOPE
		
		if(data_entity.e_is_angry() or data_entity.e_is_tenso()):
			_start_this_sub_quality("run_combat")
		else:
			_start_this_sub_quality("trotar")

#-------------------------------------------------------

#Métodos propios de la Cualdiad.
