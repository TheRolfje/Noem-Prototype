extends State_2D

var animacion_en_proceso:bool = false
var animation_finish:bool = false

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
	data.continue_the_process = false
	entity.velocity.x = 0
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
	
	match state_machine.old_state:
		"WALK":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				data.direction_look.x *= -1
				animacion_en_proceso = true
				
			if(animation_finish):
				if(data.direction_movement.x == 0):
					state_machine._switch_state("IDLE")
				else:
					state_machine._switch_state("WALK")
					
		"IDLE":
			if(!animacion_en_proceso):
				animations.play("Transicion_walk_walk") #Aca va otra animación.
				data.direction_look.x *= -1
				animacion_en_proceso = true
				
			if(animation_finish):
				if(data.direction_movement.x == 0):
					state_machine._switch_state("IDLE")
				else:
					state_machine._switch_state("WALK")
	

func action_of_end():
	data.continue_the_process = true
	animacion_en_proceso = false
	animation_finish = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_finish = true
