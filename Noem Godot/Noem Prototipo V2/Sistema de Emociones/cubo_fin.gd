extends Area2D

@export var contention_node : Contention_Emotions
@export var modo_respiracion : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("EMOTIONAL_CUBE")):
		if(modo_respiracion):
			contention_node.Accumulate_Emotion(body.color_of_cube)
		else:
			pass #llamaría a liberación.
		
		body.queue_free()
