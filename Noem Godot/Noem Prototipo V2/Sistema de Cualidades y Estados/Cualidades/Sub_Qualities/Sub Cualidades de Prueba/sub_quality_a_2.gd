extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"A-2"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	print("Ejecutando acción de inicio de SubCualidad A-2\n")

func action():
	#print("EJECUTANDO ACCIÓN A\n")
	pass
	
func action_of_end():
	print("Ejecutando acción de fin de SubCualidad A-2\n")
