extends Node2D

var malba:CharacterBody2D
var movimiento:Node2D

@export var data:data_malba
@export var state_machine:Node2D

signal travel_to_state(new_state:String)

func _ready() -> void:
	malba = self.owner
	movimiento = $"../Control_of_Skills/S_Movement"
	
	travel_to_state.connect(state_machine.new_state_signal)

func _process(delta: float) -> void:
	if(data.enemy_detected):
		emit_signal("travel_to_state", "COMBAT")
	elif(data.noem != null and state_machine.active_state.name_of_state != "SEGUIR_A_NOEM"):
		emit_signal("travel_to_state", "SEGUIR_A_NOEM")
	else:
		emit_signal("travel_to_state", "ESPERANDO_NODO_NOEM")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Enemy")):
		data.enemy_detected = true
		data.objetivo_atacado = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Enemy")):
		data.enemy_detected = false
