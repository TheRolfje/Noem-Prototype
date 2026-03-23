extends Sub_Quality

func _ready() -> void:
	name_of_subquality = &"izquierda"
	add_subquality_to_the_quality_owner()
	
func action_of_start():
	pass

func action():
	entity.velocity.x = -1 * quality_owner.speed
	
func action_of_end():
	pass
