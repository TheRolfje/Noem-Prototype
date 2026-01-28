extends Node2D

@export var data:data_enemy_v1
@export var sm_comportamientos:Node2D

var entity:CharacterBody2D
# Called when the node enters the scene tree for the first time.

@export var objetivo_a_atacar: String = "Noem" #Si esto cambia, el enemigo busca
#y ataca a otro objetivo, no a Noem. Igual esto abría que armarlo como una lista o algo.

signal travel_to_state(new_state:String)

func _ready() -> void:
	entity = self.owner
	
	travel_to_state.connect(sm_comportamientos.new_state_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(data.combatir):
		emit_signal("travel_to_state", "COMBATIR")
	elif(data.player_detected):
		emit_signal("travel_to_state", "PERSEGUIR")
	else:
		emit_signal("travel_to_state", "PATRULLAR")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body_is_objetive(body)):
		data.player_detected = true
		data.jugador = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body_is_objetive(body)):
		data.player_detected = false


func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	if(body_is_objetive(body)):
		data.objetivo_atacado = body
		data.combatir = true


func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	if(data.objetivo_atacado == body):
		data.combatir = false
		

func body_is_objetive(body :Node2D):
	#El nombre del objetivo a atacar corresponde con su grupo. Normalmente Noem.
	
	if(body.is_in_group(objetivo_a_atacar)):
		return true
	else:
		return false
