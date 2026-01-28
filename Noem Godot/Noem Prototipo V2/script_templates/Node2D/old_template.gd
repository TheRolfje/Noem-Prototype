extends Node2D

var state_machine:Node2D
var name_of_state:String
var entity:CharacterBody2D

var states_to_which_I_can_travel:Array = []
var states_that_can_travel_to_me:Array = []
#Lista con todas las claves de los estados a los que este estado puede viajar.

func _ready():
	_build_list_of_states_to_travel()
	_build_list_of_states_than_travel_to_me()
	_assign_a_state_machine()
	_add_state_to_the_machine()
	
	entity = state_machine.Entity

func _assign_a_state_machine():
	#Arrastra y añade la referencia al nodo State_Machine de la escena.
	#state_machine = ...
	pass

func _add_state_to_the_machine():
	#Dale un nombre a este estado, en mayusculas:
	name_of_state = "NAME"
	state_machine.add_new_state_to_dictionary(name_of_state, self)

func action():
	#Acción del estado:
	pass
		
func _build_list_of_states_to_travel():
	var states
	#Aquí agrega a la lista los nombres de los estados a los que este estado puede viajar.
	
	#Reemplaza los estados de ejemplo de la lista de abajo por los nombres de 
	#los estados correspondientes.
	
	states = [
		"STATE_1",
		"STATE_2",
		"etc."
		]
		
	states_to_which_I_can_travel = states
	
func _build_list_of_states_than_travel_to_me():
	var states
	#Aquí agrega a la lista los nombres de los estados que pueden viajar a este estado.
	
	#Cuando un estado nuevo se crea, dicho estado tendrá una lista con los estados a
	#los que puede viajar. Pero, también necesita que los estados sepan que pueden viajar a él, por
	#lo que necesita que dichos estados lo tengan en sus listas. 
	#Esta lista es para la que la State Machine agrege este estado a las listas
	#de los estados que aparecen aquí. 
	
	#Reemplaza los estados de ejemplo de la lista de abajo por los nombres de 
	#los estados correspondientes.
	
	states = [
		"STATE_1",
		"STATE_2",
		"etc."
		]
	
	states_that_can_travel_to_me = states

func add_a_state_to_which_I_can_travel(name_new_state:String):
	#La State Machine usará esta función para agregar un destino nuevo.
	states_to_which_I_can_travel.append(name_new_state)
