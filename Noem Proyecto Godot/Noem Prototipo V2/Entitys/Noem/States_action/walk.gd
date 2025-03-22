extends State_2D

@export var movimiento:movement_skills

var t_piedra:Timer
var t_tropiezo:Timer
var t_caida:Timer
var tropiezo:bool = false
var caer:bool = false

func _ready():
	name_of_state = "WALK"
	state_machine = $".."
	entity = state_machine.Entity
	data = state_machine.Data
	animations = state_machine.Animations
	
	t_piedra = $piedra
	t_tropiezo = $tropiezo
	t_caida = $duracion_caida
	
	#movimiento = state_machine.Control_Skills.get_node("Movement")

	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	_flip_sprite_according_to_direction()
	
	animations.play("Walk")
	
	if(data.climbing_slope):
		_walk_in_climbing_slope()
	else:
		t_piedra.stop()
		
	if(!tropiezo or !caer):
		movimiento.walk()
		
func _walk_in_climbing_slope():
	if(data.sostenerse):
		t_piedra.stop()
	else:
		if(t_piedra.is_stopped() and !tropiezo):
			t_piedra.start(1)


func _tropezar():
	if(data.climbing_slope):
		entity.velocity.x = 0
		tropiezo = true
		
		if(t_tropiezo.is_stopped()):
			t_tropiezo.start(2)
			
func _caer():
	#ejecuta animación de caida y lleva al jugador unos metros colina abajo.
	caer = true
	
	if(t_caida.is_stopped()):
		t_caida.start(0.25)
		
	entity.velocity.x = -500

func _on_piedra_timeout() -> void:
	_caer()

func _on_tropiezo_timeout() -> void:
	tropiezo = false

func _on_duracion_caida_timeout() -> void:
	tropiezo = true
	if(t_tropiezo.is_stopped()):
		t_tropiezo.start(1)
