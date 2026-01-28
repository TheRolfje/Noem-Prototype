extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Humanoid_Entity")):
		body.data.on_off_climbing_slope()


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Humanoid_Entity")):
		body.data.on_off_climbing_slope()
