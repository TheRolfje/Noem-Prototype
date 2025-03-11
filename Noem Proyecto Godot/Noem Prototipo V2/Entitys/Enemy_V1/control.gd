extends Node2D

@export var data:Node
@export var sm_comportamientos:Node2D

var entity:CharacterBody2D
# Called when the node enters the scene tree for the first time.

signal travel_to_state(new_state:String)

func _ready() -> void:
	entity = self.owner
	
	travel_to_state.connect(sm_comportamientos.new_state_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(data.player_detected):
		emit_signal("travel_to_state", "PERSEGUIR")
	else:
		emit_signal("travel_to_state", "PATRULLAR")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Noem")):
		data.player_detected = true
		data.jugador = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Noem")):
		data.player_detected = false
