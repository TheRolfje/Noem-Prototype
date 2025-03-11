extends State_2D

@export var attack_area:Area2D

var t_enfriamiento_de_ataque:Timer

var objetivo_conectado:bool = false
var ataque_construido:bool = false
var ataque_disponible:bool = true

var ataque:object_attack = object_attack.new()

signal travel_to_state(new_state:String)

func _ready():
	name_of_state = "ATACAR"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	
	t_enfriamiento_de_ataque = $Timer

	_add_state_to_the_machine(name_of_state, self)

func action():
	if(ataque_disponible):
		if(!objetivo_conectado):
			contectar_con_objetivo()
		
		if(!ataque_construido):
			construir_ataque()
			
		data.objetivo_atacado.data.attack_received = ataque
		emit_signal("travel_to_state", "TAKE_DAMAGE")
		
		ataque_disponible = false
		if(t_enfriamiento_de_ataque.is_stopped()):
			t_enfriamiento_de_ataque.start(1)
	
func contectar_con_objetivo():
	travel_to_state.connect(data.objetivo_atacado.sm_acciones.new_state_signal)
	objetivo_conectado = true
	
func construir_ataque():
	ataque.damage = data.damage
	#este ataque no hace nada más
	ataque_construido = true

func _on_timer_timeout() -> void:
	ataque_disponible = true
