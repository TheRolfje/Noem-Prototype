extends Node2D

var malba:CharacterBody2D
var movimiento:Node2D

@export var data:Node
@export var state_machine:Node2D

signal travel_to_state(new_state:String)

func _ready() -> void:
	malba = self.owner
	movimiento = $"../Control_of_Skills/S_Movement"
	
	travel_to_state.connect(state_machine.new_state_signal)

func _process(delta: float) -> void:
	if(data.noem != null and state_machine.active_state.name_of_state != "SEGUIR_A_NOEM"):
		emit_signal("travel_to_state", "SEGUIR_A_NOEM")
