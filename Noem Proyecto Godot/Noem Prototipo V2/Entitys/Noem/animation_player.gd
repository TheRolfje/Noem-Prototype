extends AnimationPlayer

@export var state_machine:State_Machine

var change_of_state_requested:bool = false

signal optimal_frame
signal point_of_inflection


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.connect("request_of_change_of_state", Callable(self, "request_change"))
	state_machine.connect("state_changed", Callable(self, "state_changed"))

func request_change():
	change_of_state_requested = true
	
func state_changed():
	change_of_state_requested = false

func emit_optimal_frame():
	if(change_of_state_requested):
		print("señal emitida")
		emit_signal("optimal_frame")
	
func emit_point_of_inflection():
	if(change_of_state_requested):
		emit_signal("point_of_inflection")
