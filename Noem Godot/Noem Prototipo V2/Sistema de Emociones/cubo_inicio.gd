extends Area2D

class_name Cube_Builder

@export var destructor_de_cubo : Area2D

var cube_trajectory : int = -1

var cube_emotion = preload("res://Sistema de Emociones/emotion_cube.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(destructor_de_cubo.global_position.x <= self.global_position.x):
		cube_trajectory = -1 #Envia el cubo hacia la izquierda
	else:
		cube_trajectory = 1 #Envia el cubo hacia la derecha.
		
func Build_and_Send_Emotion_Cube(color : int): #valor del enum de emociones
	var cube : Cube_Emotion = cube_emotion.instantiate()
	cube.sprite.visible = false
	cube.Connect_with_Area(self) #permite que se conecte a las señales del area solo
								#esta intancia del cubo, y no todas.
	
	call_deferred("add_child", cube) #Se usa porque porque parece que el motor de godot
	#tiene problemas para agregar un nodo de físicas nuevos mientras ya está calculando
	#físicas.
	
	cube.Set_Color_Emotion(color)
	
	cube.Send_Emotion(cube_trajectory)
