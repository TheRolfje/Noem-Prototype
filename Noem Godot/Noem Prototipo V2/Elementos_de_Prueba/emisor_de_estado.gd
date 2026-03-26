extends Node2D

#Cuando esto es tocado por una Entidad con un "Detector de Entorno", lee el nombre y tipo de estado
#al que tiene que cambiar.

class_name activador_de_estado

@export var tipo : StringName
@export var nombre : StringName

func _ready() -> void:
	add_to_group("Activador_de_Estado")
