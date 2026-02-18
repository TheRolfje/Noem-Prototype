extends CharacterBody2D

@export var quality_manager : Qualities_Manager

signal change_active_quality(new_quality : StringName)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	quality_manager.execute_default_quality()
	change_active_quality.connect(quality_manager.change_active_quality)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if (Input.is_action_just_pressed("support_yourself")):
		change_active_quality.emit(&"Quality_B")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	quality_manager.action_of_active_SUB_quality()

	move_and_slide()
