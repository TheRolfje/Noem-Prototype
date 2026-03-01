extends CharacterBody2D

@export var quality_manager : Qualities_Manager
@export var state_manager : State_Manager

signal change_active_quality(new_quality : StringName)
signal change_this_type_of_active_state(new_state : StringName, type_state : StringName)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	quality_manager.execute_default_quality()
	change_active_quality.connect(quality_manager.change_active_quality)
	change_this_type_of_active_state.connect(state_manager.change_active_state)
	
	change_this_type_of_active_state.emit(&"l_state_a", State_Type.LOCOMOTIONAL)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if (Input.is_action_just_pressed("Stealth")):
		print("\nCambiar a Estado B")
		change_this_type_of_active_state.emit(&"l_state_b", State_Type.LOCOMOTIONAL)
	
	if (Input.is_action_just_pressed("shift")):
		print("\nCambiar a Estado A")
		change_this_type_of_active_state.emit(&"l_state_a", State_Type.LOCOMOTIONAL)
	
	if (Input.is_action_just_pressed("support_yourself")):
		print("\nCambiar a Qualidad B")
		change_active_quality.emit(&"Quality_B")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		print("\nCambiar a Qualidad A")
		change_active_quality.emit(&"Quality_A")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	state_manager.action_of_active_states()
	quality_manager.action_of_active_SUB_quality()

	move_and_slide()
