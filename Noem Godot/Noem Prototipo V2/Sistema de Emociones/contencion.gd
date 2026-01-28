extends Node

class_name Contention_Emotions

var accumulated_emotions : Dictionary[Color, int] = {}#Acumula emociones por color.

func Accumulate_Emotion(color : Color):
	if not accumulated_emotions.has(color):
		accumulated_emotions[color] = 0
		#Evita errores al hacer += 1 con colores nuevos.
	accumulated_emotions[color] += 1
	
	
