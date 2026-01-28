extends Sprite2D

class_name Viewvers

var visor_abierto: bool = false
var modo_respiracion_abierto : bool = false
@export var animations : AnimationPlayer
@export var close_viewver_timer : Timer

func Open_Breathing_Mode():
	animations.play("Open_Breathing_Mode")
	await animations.animation_finished
	
	modo_respiracion_abierto = true
	
func Close_Breathing_Mode():
	animations.play_backwards("Open_Breathing_Mode")
	await animations.animation_finished
	
	modo_respiracion_abierto = false
	
func Oper_Viewver():
	if(!visor_abierto):
		animations.play("Open_Emotion_Viewver")
		await animations.animation_finished
		
		visor_abierto = true
		close_viewver_timer.start()
	else:
		close_viewver_timer.start() #resetea el timer si recibe otra señal.

func Close_Viewver():
	animations.play_backwards("Open_Emotion_Viewver")
	await animations.animation_finished
	
	visor_abierto = false


func _on_timer_timeout() -> void:
	Close_Viewver()
