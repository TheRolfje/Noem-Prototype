extends State_2D

@export var movimiento:movement_skills
@export var animation_node:AnimationPlayer

var t_piedra:Timer
var t_tropiezo:Timer
var t_caida:Timer
var tropiezo:bool = false
var caer:bool = false

var critical_frame_achieved:bool = false
var last_direction:float = 0

func _ready():
	name_of_state = "WALK"
	state_machine = $".."
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations
	
	#animations.point_of_inflection.connect(_critial_frame_achieved)
	
	t_piedra = $piedra
	t_tropiezo = $tropiezo
	t_caida = $duracion_caida
	
	#movimiento = state_machine.Control_Skills.get_node("Movement")

	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	_flip_sprite_according_to_direction()
	
	if(data.direction_movement.x != 0):
		last_direction = data.direction_movement.x
	
	animations.play("Walk")
	
	walk_according_to_the_active_terrain()
	
	if(data.climbing_slope):
		_walk_in_climbing_slope()
	else:
		t_piedra.stop()
		
	if(!tropiezo or !caer):
		movimiento.walk()
		
func action_of_end():
	pass
	#data.continue_the_process = false
	#
	#if(animations.point_of_inflection_reached):
		#entity.velocity.x = last_direction * data.walk_speed
		#await animations.optimal_frame
	#else:
		#animations.play_backwards("Walk")
		#entity.velocity.x = last_direction * data.walk_speed * -1
		#await animations.optimal_frame
		#
	#critical_frame_achieved = false
	#data.continue_the_process = true

func walk_according_to_the_active_terrain():
	match data.moving_in:
		data.Terrain.NEUTRAL_TERRAIN:
			print("camino normal")
		data.Terrain.SLOPE:
			print("escalando pendiente")
		data.Terrain.LADDER:
			print("subiendo escalera")

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
		
#func _critial_frame_achieved():
	#critical_frame_achieved = true
