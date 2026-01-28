extends Node2D

enum STATE{
	IDLE,
	WALK,
	TRANSITION_IDLE_WALK,
	TRANSITION_WALK,
	TRANSITION_IDLE,
	DESENFUDAR
}

enum OLD_STATE{
	IDLE,
	WALK,
	TRANSITION_IDLE_WALK,
	TRANSITION_WALK,
	TRANSITION_IDLE,
	DESENFUDAR
}

var timer_idle:Timer
var timer_verdadero_idle:Timer

var active_state:STATE = STATE.IDLE
var old_state:OLD_STATE = OLD_STATE.IDLE
var noem:Noem_V1
var noem_quieto:bool = true
var verdadero_idle:bool = true
var animation_finished:bool = false

#Velocidades:
@export var walk_speed:float
@export var transition_speed:float
@export var transition_idle_speed:float

var frame_actual

var movimiento:int
var direction:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	noem = self.owner
	timer_idle = $Timer_Noem_Quieto
	timer_verdadero_idle = $Timer_Verdadero_Idle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print("BASIC_MOVEMENT")
	
	movimiento = Input.get_axis("Izquierda","Derecha")
	
	match active_state:
			STATE.IDLE:
				print("Idle")
				_idle()
			STATE.WALK:
				print("Walk")
				_walk()
			STATE.TRANSITION_WALK:
				print("transition_walk")
				_transition_from_walk()
			STATE.TRANSITION_IDLE:
				print("Transition_idle")
				_transition_from_idle()
			STATE.TRANSITION_IDLE_WALK:
				#print("Transition_idle_walk")
				_transition_idle_walk()
			STATE.DESENFUDAR:
				_desenfundar()
	#frame_actual = $"../Sprite_Noem_V1".frame
	#print(frame_actual)
	
	noem.move_and_slide()

func _idle():
	noem.velocity.x = 0
	
	#Timer para la transición de walk a walk. Verifica si Noem paso X tiempo en Idle.
	#Si se cumple, entonces la transición que se ejecuta es la Idle a Idle, sino la de Walk a Walk
	if(timer_verdadero_idle.is_stopped()):
		timer_verdadero_idle.start()
	
	#Timer de noem quieto. Si pasan x segundos es como la animación de que el personaje se aburre y hace algo.
	#En este caso, aparte de sus animaciones de idle, al volver a caminar habrá una transición. Si no se cumple, noem
	#simplemente camina.
	if(timer_idle.is_stopped()):
		timer_idle.start()
	
	if(movimiento == 0):
		$"../Sprite_Noem_V1/Control_de_animaciones".set("parameters/TimeScale/scale", 1)
		
		if(noem.direction):
			noem.animacion_en_reproduccion.travel("Idle")
		else:
			noem.animacion_en_reproduccion.travel("Idle_izq")
	else:
		noem_quieto = false
		noem.control.old_state = STATE.IDLE
		noem.control._switch_state()

func _walk():
	
	$"../Sprite_Noem_V1/Control_de_animaciones".set("parameters/TimeScale/scale", walk_speed)

	if(noem.direction):
		noem.animacion_en_reproduccion.travel("Walk")
	else:
		noem.animacion_en_reproduccion.travel("Walk_izq")

	noem.velocity.x = noem.speed * movimiento
	if(movimiento != direction):
		print("sali")
		noem.control.old_state = STATE.WALK
		noem.control._switch_state()

func _transition_from_idle():
	noem.velocity.x = 0
	
	if(!animation_finished):
	
		if(noem.direction):
			noem.animacion_en_reproduccion.travel("Transition_Idle_Idle")
		else:
			noem.animacion_en_reproduccion.travel("Transition_Idle_Idle_izq")
	else:
		noem.control.old_state = STATE.TRANSITION_IDLE
		noem.control._switch_state()

func _transition_from_walk():
	noem.velocity.x = 0
	
	if(noem.direction):
		noem.animacion_en_reproduccion.travel("Transition")
	else:
		noem.animacion_en_reproduccion.travel("Transition_izq")
	
	if(animation_finished):
		_switch_direction()
		
		if(movimiento == 0):
			active_state = STATE.IDLE
		else:
			active_state = STATE.WALK
		
		old_state = OLD_STATE.TRANSITION_WALK
		
		animation_finished = false
		
func _transition_idle_walk():
	noem.velocity.x = 0
	
	if(noem.direction):
		noem.animacion_en_reproduccion.travel("Transition_Idle_Walk")
	else:
		noem.animacion_en_reproduccion.travel("Transition_Idle_Walk_izq")
	
	if(animation_finished):
		active_state = STATE.WALK
		old_state = OLD_STATE.TRANSITION_IDLE_WALK
		
		animation_finished = false

func _desenfundar():
	
	active_state = STATE.IDLE
	
	noem.control.super_new_state = noem.control.SUPER_STATE.GUN
	noem.control.super_old_state = noem.control.SUPER_STATE.BASIC_MOVEMENT
	
	noem.control._switch_super_state()

func _switch_direction():
	#noem.scale.x *= -1 #Cambia de direccion el nodo ChracterBody (Noem)
	noem.direction = !noem.direction #indica que la direccion se cambio
	
	if(noem.direction):
		direction = 1
	else:
		direction = -1

#Si la transicion termina se levanta la flag, asi solo se pasa a otro estado si
#la transicion termino
func _on_control_de_animaciones_animation_finished(anim_name):
	animation_finished = true

#Timer de Verdadero Idle
func _on_timer_timeout():
	if(active_state == STATE.IDLE):
		noem_quieto = true

func _on_timer_verdadero_idle_timeout():
	if(active_state == STATE.IDLE):
		verdadero_idle = true
