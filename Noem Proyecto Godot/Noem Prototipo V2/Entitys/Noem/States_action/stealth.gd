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
	animations.play("Agacharse")
	await animations.animation_finished

func action():
	print("AGACHADO")
	_flip_sprite_according_to_direction()
	
	if(data.direction_movement.x != 0):
		movimiento._move_entity_x(20)
		animations.play("Walk_agachado")
	else:
		entity.velocity.x = 0
		animations.play("Agachado")

func action_of_end():
	animations.play("Levantarse_de_agachado")
	await animations.animation_finished
	print("termine")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if(anim_name == "Levantarse_de_agachado"):
		print("animación iniciada")
