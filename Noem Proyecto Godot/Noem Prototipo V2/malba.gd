extends CharacterBody2D

var control:Node2D
var data:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	control = $Control
	data = $Data
	data.direction_look.x = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	control.seguimiento()
	
	move_and_slide()
