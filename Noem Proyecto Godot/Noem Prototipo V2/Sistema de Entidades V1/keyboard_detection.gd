extends Node2D

var control:Node2D
var data:Node

func _ready() -> void:
	control = $"../Control"
	data = $"../Data"

func _process(delta: float) -> void:
	
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
