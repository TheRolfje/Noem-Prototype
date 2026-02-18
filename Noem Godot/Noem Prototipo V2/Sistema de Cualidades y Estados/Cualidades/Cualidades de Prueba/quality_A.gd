extends Quality

func _ready() -> void:
	name_of_quality = &"Quality_A"
	add_this_quality_to_the_manager()
	assing_this_quality_ass_default_quality()

func quality_start_action(): #Acción de inicio de la Cualidad.
	print("Ejecutando Acción de inicio de Cualidad A \n")
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	print("Ejecutando acción de fin de Cualidad A \n")
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	_start_this_sub_quality(&"A")
