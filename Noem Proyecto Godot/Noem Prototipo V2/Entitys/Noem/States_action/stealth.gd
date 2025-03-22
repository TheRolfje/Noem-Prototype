extends State_2D

@export var movimiento:movement_skills

var animation_finished:bool = false
var animation_in_progres:bool = false

func _ready():
	name_of_state = "STEALTH"
	state_machine = $".." 
	entity = self.owner
	data = state_machine.Data
	animations = state_machine.Animations

	
	states_to_which_I_can_travel = []
	states_that_can_travel_to_me = []
	interruptions_not_allowed = []

	_add_state_to_the_machine(name_of_state, self)
	
func action_of_start():
	if(!animation_in_progres):
		animations.play("Agacharse")
		animation_in_progres = true
	
	if(animation_finished):
		animation_finished = false
		return true
	else:
		return false

func action():
	_flip_sprite_according_to_direction()
	
	if(data.direction_movement.x != 0):
		movimiento._move_entity_x(20)
		animations.play("Walk_agachado")
	else:
		entity.velocity.x = 0
		animations.play("Agachado")

func action_of_end():
	if(!animation_in_progres):
		animations.play("Levantarse_de_agachado")
		animation_in_progres = true
	
	if(animation_finished):
		animation_finished = false
		return true
	else:
		return false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_finished = true
	animation_in_progres = false
