extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"B"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	print("Ejecutando acción de inicio de SubCualidad B\n")

func action():
	#print("EJECUTANDO ACCIÓN B\n")
	pass
	
func action_of_end():
	print("Ejecutando acción de fin de SubCualidad B\n")
