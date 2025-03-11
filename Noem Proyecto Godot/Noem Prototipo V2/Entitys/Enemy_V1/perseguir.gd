extends State_2D

@export var sm_acciones:State_Machine

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "PERSEGUIR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	travel_to_state.connect(sm_acciones.new_state_signal)

	_add_state_to_the_machine(name_of_state, self)

func action():
	if(sm_acciones.active_state.name_of_state != "ATACAR"):
		data.set_direction_move_x(sign(data.jugador.global_position.x - entity.global_position.x))
			
		emit_signal("travel_to_state", "RUN")
		


func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Noem")):
		data.objetivo_atacado = body
		emit_signal("travel_to_state", "ATACAR")


func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	if(body == data.objetivo_atacado):
		emit_signal("travel_to_state", "RUN")
