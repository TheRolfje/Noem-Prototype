extends State_2D

var animacion_en_proceso:bool = false
var animation_finish:bool = false
var old_old_state:String
var action_run:bool = false

var transicionar_de_nuevo:bool = false

func _ready():
	name_of_state = "TRANSITION"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations

	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)

func action():
	#Hay que crear grupos de estados a los que Transición reacciona. 
	entity.velocity.x = 0
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
	
	if(data.direction_look.x == data.direction_movement.x * -1):
		transicionar_de_nuevo = true
		old_old_state = state_machine.old_state.name_of_state
		
	if(!action_run):
		_accion_segun_old_state() # <- Esto ejecuta una animación
	
	if(animation_finish):
		action_run = false
			
		if(transicionar_de_nuevo):
			_flip_sprite_according_to_direction()
			action_of_start()
			state_machine.old_state = state_machine.States_in_the_Machine[old_old_state]
			_accion_segun_old_state()
		else:
			if(state_machine.old_state.name_of_state == "STEALTH"):
				state_machine._switch_state("STEALTH")
			elif(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
				state_machine._switch_state("RUN")
			elif (data.direction_movement.x != 0):
				state_machine._switch_state("WALK")
			elif (data.direction_movement.x == 0):
				state_machine._switch_state("IDLE")
				
func _accion_segun_old_state():
	action_run = true
	
	match state_machine.old_state.name_of_state:
		"WALK":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true
					
		"IDLE":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true
		"STEALTH":
			animation_finish = true
		_:
			action_run = false
			pass

func action_of_end():
	data.continue_the_process = true

func action_of_start():
	data.direction_look.x *= -1
	data.continue_the_process = false
	animacion_en_proceso = false
	animation_finish = false
	transicionar_de_nuevo = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_finish = true
