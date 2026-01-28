extends CharacterBody2D

@export var control:Node2D
@export var data:Node
@export var sm_comportamientos:Node2D
var sm_acciones:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sm_acciones = $S_M_Acciones
	data.direction_look.x = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	sm_comportamientos.active_state.action()
	sm_acciones.active_state.action()
	
	move_and_slide()
