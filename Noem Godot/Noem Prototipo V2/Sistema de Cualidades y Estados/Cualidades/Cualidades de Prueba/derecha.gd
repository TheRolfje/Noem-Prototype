extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"derecha"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	pass
	#print("\nINICIANDO MOVIMIENTO\n")

func action():
	entity.velocity.x = quality_owner.speed
	
func action_of_end():
	pass
