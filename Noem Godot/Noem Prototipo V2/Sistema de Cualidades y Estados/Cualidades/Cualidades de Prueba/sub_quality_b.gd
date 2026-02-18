extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"B"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	pass

func action():
	print("ACCIÓN DE SUBCUALIDAD B")
	return_to_quality_default()
	
func action_of_end():
	pass
