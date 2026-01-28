extends Node2D

enum SUPER_STATE{
	#Super Estados:
	BASIC_MOVEMENT,
	GUN,
	COVERAGE,
	INVENTORY_OPEN
}

enum STATE{
	#Movimiento Basico:
	IDLE,
	WALK,
	TRANSITION_IDLE_WALK,
	TRANSITION_WALK,
	TRANSITION_IDLE,
	DESENFUDAR,
	
	#Combate Armado:
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

var noem:Noem_V1

var super_new_state:SUPER_STATE
var super_old_state:SUPER_STATE

var old_state:STATE
var new_state:STATE

# Called when the node enters the scene tree for the first time.
func _ready():
	noem = self.owner

#Cambia el super estado de noem entre los distintos nodos que controlan su movimiento:
func _switch_super_state():
	_off_physics_process_old_state()
	_on_physics_process_new_state()

#Desactiva el "physics process" del estado asignado como "old state"
func _off_physics_process_old_state():
	match super_old_state:
		SUPER_STATE.BASIC_MOVEMENT:
			noem.basic_movement.set_physics_process(false)
		SUPER_STATE.GUN:
			noem.gun.set_physics_process(false)
		SUPER_STATE.COVERAGE:
			pass
		SUPER_STATE.INVENTORY_OPEN:
			pass

#Activa el "physics process" del estado asignado como "new state"
func _on_physics_process_new_state():
	match super_new_state:
		SUPER_STATE.BASIC_MOVEMENT:
			noem.basic_movement.set_physics_process(true)
		SUPER_STATE.GUN:
			noem.gun.set_physics_process(true)
		SUPER_STATE.COVERAGE:
			pass
		SUPER_STATE.INVENTORY_OPEN:
			pass

#/////////////////////////////////////////////////////////////////////////

#Cambia el estado de Noem dentro del Super Estado en el que se encuentre
func _switch_state():
	#Pregunta en que Super Estado esta Noem para redirigir a la función adecuada
	match super_old_state:
		SUPER_STATE.BASIC_MOVEMENT:
			_switch_state_of_basic_movement()
		SUPER_STATE.GUN:
			_switch_state_of_gun()
		SUPER_STATE.COVERAGE:
			pass
		SUPER_STATE.INVENTORY_OPEN:
			pass

#Cambia los estados dentro del nodo de movimiento basico
func _switch_state_of_basic_movement():
	match old_state:
		STATE.IDLE:
			
			if(((noem.direction == true and noem.basic_movement.movimiento < 0) or\
			 (noem.direction == false and noem.basic_movement.movimiento > 0)) and !noem.basic_movement.verdadero_idle):
				#Resulta que siempre al cambiar de dirección Noem a veces se queda quieto una milesima de segundo,
				#tiempo en el que regresa a Idle, por eso la transición de walk está también aca para cuando eso pasa.
				#En ese caso, solo se cambia el estado y se sale de la función idle para que no se ejecute nada más.
				#No me gusta mucho como quedó pero bueno xd
				
				new_state = STATE.TRANSITION_WALK
				noem.basic_movement.noem_quieto = false
			
			#direction = true es derecha, false es izquierda.
			#Si Noem va en una dirección y detecta movimiento hacia la otra cambia a estado de transicion
			if(noem.basic_movement.verdadero_idle and ((noem.direction == true and noem.basic_movement.movimiento < 0) or\
			 (noem.direction == false and noem.basic_movement.movimiento > 0))):
				noem.basic_movement.timer_idle.stop()
				noem.basic_movement.timer_verdadero_idle.stop()
				new_state = STATE.TRANSITION_IDLE
				noem.basic_movement.verdadero_idle = false
				noem.basic_movement.noem_quieto = false
			elif((noem.direction == true and noem.basic_movement.movimiento > 0) or \
			(noem.direction == false and noem.basic_movement.movimiento < 0)):
				if(noem.basic_movement.noem_quieto):
					new_state = STATE.TRANSITION_IDLE_WALK
					noem.basic_movement.noem_quieto = false
				else:
					noem.basic_movement.timer_idle.stop()
					noem.basic_movement.timer_verdadero_idle.stop()
					new_state = STATE.WALK
					noem.basic_movement.noem_quieto = false
					
			if(Input.is_action_pressed("apuntar")):
				new_state = STATE.DESENFUDAR
		
				return
				
		STATE.WALK:
			if(Input.is_action_pressed("apuntar")):
				new_state = STATE.DESENFUDAR
				return
		
			if((noem.direction == true and Input.is_action_pressed("Izquierda")) or\
	 		(noem.direction == false and Input.is_action_pressed("Derecha"))):
				new_state = STATE.TRANSITION_WALK

			elif(noem.basic_movement.movimiento == 0):
				new_state = STATE.IDLE
	
		STATE.TRANSITION_IDLE_WALK:
			pass
		STATE.TRANSITION_WALK:
			pass
		STATE.TRANSITION_IDLE:
				noem.basic_movement._switch_direction()
		
				if(noem.basic_movement.movimiento == 0):
					new_state = STATE.IDLE
				else:
					new_state = STATE.WALK
		
				noem.basic_movement.animation_finished = false
		STATE.DESENFUDAR:
			pass
	
	noem.basic_movement.active_state = new_state


#Cambia los estados dentro del nodo de combate armado
func _switch_state_of_gun():
	match old_state:
		STATE.ARM_IN_HAND:
			pass
		STATE.WALK_ARM_IN_HAND:
			pass
		STATE.AIMING:
			pass
		STATE.WALK_AIMING:
			pass
		STATE.FIJADO:
			pass
		STATE.SHOT:
			pass
		STATE.RELOAD:
			pass
		STATE.TRANSITION_HAND_AIMING:
			pass
		STATE.TRANSITION_WALK_HAND_WALK_AIMING:
			pass
		STATE.TRANSITION_AIMING_AIMING:
			pass
		STATE.TRANSITION_WALK_AIMING_WALK_AIMING:
			pass
		STATE.ARM_DOWN:
			pass
		STATE.ENFUNDAR:
			pass
