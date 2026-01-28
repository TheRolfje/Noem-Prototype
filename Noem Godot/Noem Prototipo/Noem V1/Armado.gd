extends Node2D

var noem:Noem_V1

var movimiento:float

enum STATE{
	ARM_IN_HAND,
	WALK_ARM_IN_HAND,
	AIMING,
	WALK_AIMING,
	FIJADO,
	SHOT,
	RELOAD,
	TRANSITION_HAND_AIMING,
	TRANSITION_WALK_HAND_WALK_AIMING,
	TRANSITION_AIMING_AIMING,
	TRANSITION_WALK_AIMING_WALK_AIMING,
	ARM_DOWN,
	ENFUNDAR
}

enum OLD_STATE{
	ARM_IN_HAND,
	WALK_ARM_IN_HAND,
	AIMING,
	WALK_AIMING,
	FIJADO,
	SHOT,
	RELOAD,
	TRANSITION_HAND_AIMING,
	TRANSITION_WALK_HAND_WALK_AIMING,
	TRANSITION_AIMING_AIMING,
	TRANSITION_WALK_AIMING_WALK_AIMING,
	ARM_DOWN,
	ENFUNDAR
}

var active_state:STATE = STATE.ARM_IN_HAND
var old_state:OLD_STATE

# Called when the node enters the scene tree for the first time.
func _ready():
	noem = self.owner


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print("GUN")
	
	movimiento = Input.get_axis("Izquierda","Derecha")
	
	if(Input.is_action_just_pressed("enfundar")):
		active_state = STATE.ENFUNDAR
	
	match active_state: 
		STATE.ARM_IN_HAND:
			_arm_in_hand()
		STATE.WALK_ARM_IN_HAND:
			_walk_arm_in_hand()
		STATE.AIMING:
			_aiming()
		STATE.WALK_AIMING:
			_walk_aiming()
		STATE.FIJADO:
			_fijado()
		STATE.SHOT:
			_shot()
		STATE.RELOAD:
			_reload()
		STATE.TRANSITION_HAND_AIMING:
			_transition_hand_aiming()
		STATE.TRANSITION_WALK_HAND_WALK_AIMING:
			_transition_walk_hand_walk_aiming()
		STATE.TRANSITION_AIMING_AIMING:
			_transition_aiming_aiming()
		STATE.TRANSITION_WALK_AIMING_WALK_AIMING:
			_transition_walk_aiming_walk_aiming()
		STATE.ARM_DOWN:
			_arm_down()
		STATE.ENFUNDAR:
			_enfundar()
			
	noem.move_and_slide()
	
func _arm_in_hand():
	pass
	
func _walk_arm_in_hand():
	pass
	
func _aiming():
	noem.animacion_en_reproduccion.travel("Idle")
	noem.velocity.x = 0
	
	if(Input.is_action_pressed("apuntar")):
		if(movimiento != 0):
			active_state = STATE.WALK_AIMING
			old_state = OLD_STATE.AIMING
	else:
		active_state = STATE.ARM_IN_HAND
	
func _walk_aiming():
	noem.animacion_en_reproduccion.travel("Idle")
	
	noem.velocity.x = noem.speed * movimiento
	
	if(Input.is_action_pressed("apuntar")):
		if(movimiento == 0):
			active_state = STATE.AIMING
			old_state = OLD_STATE.WALK_AIMING
	else:
		if(movimiento != 0):
			active_state = STATE.WALK_ARM_IN_HAND
			old_state = OLD_STATE.WALK_AIMING
		else:
			active_state = STATE.ARM_IN_HAND
			old_state = OLD_STATE.WALK_AIMING
	
func _fijado():
	pass
	
func _shot():
	pass
	
func _reload():
	pass
	
func _transition_hand_aiming():
	pass
	
func _transition_walk_hand_walk_aiming():
	pass
	
func _transition_aiming_aiming():
	pass
	
func _transition_walk_aiming_walk_aiming():
	pass

func _arm_down():
	pass
	
func _enfundar():
	
	active_state = STATE.ARM_IN_HAND
	
	noem.control.super_new_state = noem.control.SUPER_STATE.BASIC_MOVEMENT
	noem.control.super_old_state = noem.control.SUPER_STATE.GUN
	
	noem.control._switch_super_state()
