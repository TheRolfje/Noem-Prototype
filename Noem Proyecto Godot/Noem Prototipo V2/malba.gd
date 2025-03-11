extends CharacterBody2D

var control:Node2D
var data:Node
var state_machine:Node2D
var sm_acciones:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	control = $Control
	data = $Data
	state_machine = $S_M_Comportamientos
	sm_acciones = $S_M_Acciones
	data.direction_look.x = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	state_machine.active_state.action()
	sm_acciones.active_state.action()
	
	move_and_slide()
