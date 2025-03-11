extends CharacterBody2D

@export var SM_comportamientos:State_Machine
@export var SM_acciones:State_Machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	SM_comportamientos.active_state.action()
	SM_acciones.active_state.action()
	
	move_and_slide()
