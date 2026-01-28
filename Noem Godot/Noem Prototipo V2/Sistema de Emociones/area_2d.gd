extends Area2D

@export var timer_desbloqueo : Timer

var area_bloqueada : bool = false
var emotions : Array = []

var emotions_in_area : int = 0

func _process(delta: float) -> void:
	
	if(Input.is_action_just_pressed("Contener")):
		if(not emotions.is_empty()):
			var cube = emotions[emotions_in_area - 1]
			emotions.erase(cube)
			cube.queue_free()
			#Esto después deberia ejecutar una animación del cubo eliminandose
			
			emotions_in_area -= 1
		else:
			area_bloqueada = true
			timer_desbloqueo.start()
			#Esto debería ejecutar una animación de bloqueo en el vísor para que
			#se entienda que está bloqueado. También poner el fondo en rojo o algo así
			#mientras se está bloqueado

func _on_body_entered(body: Node2D) -> void:
	if(not area_bloqueada):
		if(body.is_in_group("EMOTIONAL_CUBE")):
			emotions.append(body)
			emotions_in_area += 1


func _on_timer_timeout() -> void:
	area_bloqueada = false
