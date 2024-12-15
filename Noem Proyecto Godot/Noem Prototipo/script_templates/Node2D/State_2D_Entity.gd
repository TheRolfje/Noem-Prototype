extends Node2D

var state_machine:Node2D
var name_of_state:String
var entity:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_assign_state_machine()
	_add_state_to_the_machine()
	
	entity = state_machine.Entity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func action():
	#Acción del estado:
	pass
	
	if(!_condition_of_permanence()):
		#Si "_condition_of_permanence()" retorna false, se saldrá del estado
		_transition_of_state()
		pass

func _transition_of_state():
	var name_of_new_state:String
	
	#Programa las transiciones a otros estados.
	#Asigna el nombre del nuevo estado a "name_of_new_state"
	
	state_machine.switch_state(name_of_new_state, self)
	
	pass

func _assign_state_machine():
	#Arrastra y añade la referencia al nodo State_Machine de la escena.
	#state_machine = ...
	pass

func _add_state_to_the_machine():
	#Dale un nombre a este estado, en mayusculas:
	name_of_state = "NAME"
	state_machine.add_state(name_of_state)
	
func _condition_of_permanence():
	#Reemplaza "CONDICION" por la condicion para permanecer en el estado
	
	#if(CONDICION):
	#	return true
	#else:
	#	return false
	pass
