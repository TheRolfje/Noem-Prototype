extends State_2D

var animacion_en_proceso:bool = false
var animation_finish:bool = false
var old_old_state:String

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
	
	if(state_machine.old_state == "TRANSITION"):
		state_machine.old_state = old_old_state
		print(old_old_state)
	
	match state_machine.old_state:
		"WALK":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true
				
			if(animation_finish):
				if(data.direction_look.x == data.direction_movement.x * -1):
					if(data.direction_look.x >= 0):
						entity.get_node("Sprite2D").scale.x = 1
					else:
						entity.get_node("Sprite2D").scale.x = -1
					print("Entre")
					state_machine._switch_state("TRANSITION")
				if(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
					state_machine._switch_state("RUN")
				elif (data.direction_movement.x != 0):
					state_machine._switch_state("WALK")
				elif (data.direction_movement.x == 0):
					state_machine._switch_state("IDLE")
					
		"IDLE":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				animacion_en_proceso = true
				
			if(animation_finish):
				if(data.direction_look.x == data.direction_movement.x * -1):
					print("Entre")
					if(data.direction_look.x >= 0):
						entity.get_node("Sprite2D").scale.x = 1
					else:
						entity.get_node("Sprite2D").scale.x = -1
					state_machine._switch_state("TRANSITION")
				if(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
					state_machine._switch_state("RUN")
				elif (data.direction_movement.x != 0):
					state_machine._switch_state("WALK")
				elif (data.direction_movement.x == 0):
					state_machine._switch_state("IDLE")
	

func action_of_end():
	data.continue_the_process = true
	animacion_en_proceso = false
	animation_finish = false

func action_of_start():
	data.direction_look.x *= -1
	data.continue_the_process = false
	
	if(state_machine.old_state != "TRANSITION"):
		old_old_state = state_machine.old_state

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_finish = true
