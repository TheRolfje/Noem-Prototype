extends Area2D

class_name Rock

var velocity_x:float = 100
var direccion_de_lanzamiento:Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	#direccion_de_lanzamiento.y = 980 * delta
	position += velocity_x * direccion_de_lanzamiento * delta
	
func lanzar(origen:Vector2 ,objetivo:Vector2):
	direccion_de_lanzamiento = (objetivo - origen).normalized()
	print(origen, " ", objetivo, " ", direccion_de_lanzamiento)


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Enemy")):
		queue_free()
