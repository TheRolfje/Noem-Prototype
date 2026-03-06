extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"B-2"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	print("Ejecutando acción de inicio de SubCualidad B-2\n")

func action():
	#print("EJECUTANDO ACCIÓN B-2\n")
	pass
	
func action_of_end():
	print("Ejecutando acción de fin de SubCualidad B-2\n")
