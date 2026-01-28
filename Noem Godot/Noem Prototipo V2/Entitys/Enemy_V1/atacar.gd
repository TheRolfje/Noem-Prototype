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
		if(!ataque_construido):
			construir_ataque()
			
		#Envia el ataque al objetivo
		send_attack()
		
		#Emite una señal de accion para las emociones de Noem
		Action_Signal.emit_signal("action_realized", Actions.Actions_Loaded.DISPARO)
		
		ataque_disponible = false
		if(t_enfriamiento_de_ataque.is_stopped()):
			t_enfriamiento_de_ataque.start(1)
	
func construir_ataque():
	ataque.damage = data.damage
	#este ataque no hace nada más
	ataque_construido = true
	
func send_attack():
	#Conecta con el nodo "Combat_system" del objetivo
	var objetivo = data.objetivo_atacado.get_node("Combat_System")
	objetivo.recive_attack_object(ataque)

func _on_timer_timeout() -> void:
	ataque_disponible = true
