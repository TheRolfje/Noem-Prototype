extends Node2D

@export var Modo_Timer : bool = false
@export var timer : Timer
@export var accion : Actions.Actions_Loaded

func _ready() -> void:
	if(Modo_Timer):
		timer.start()
		$Area2D.monitoring = false
	else:
		$Area2D.monitoring = true

func _on_timer_timeout() -> void:
	Emitir_Accion()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Noem")):
		Emitir_Accion()

func Emitir_Accion():
	Action_Signal.emit_signal("action_realized", accion)
