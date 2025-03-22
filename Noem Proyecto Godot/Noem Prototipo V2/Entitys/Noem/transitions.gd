extends State_2D

var animacion_en_proceso:bool = false
var animation_finish:bool = false
var old_old_state:String

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
		old_old_state = state_machine.old_state
		
	_accion_segun_old_state()
	
	if(animation_finish):
		if(transicionar_de_nuevo):
			action_of_start()
			state_machine.old_state = old_old_state
			entity.get_node("Sprite2D").scale.x = -1 * entity.get_node("Sprite2D").scale.x
			_accion_segun_old_state()
		else:
			if(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
				state_machine._switch_state("RUN")
			elif (data.direction_movement.x != 0):
				state_machine._switch_state("WALK")
			elif (data.direction_movement.x == 0):
				state_machine._switch_state("IDLE")
				
func _accion_segun_old_state():
	match state_machine.old_state:
		"WALK":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true
					
		"IDLE":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true

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
