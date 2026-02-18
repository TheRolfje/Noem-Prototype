extends Quality

func _ready() -> void:
	name_of_quality = &"Quality_B"
	add_this_quality_to_the_manager()

func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	_start_this_sub_quality(&"B")
