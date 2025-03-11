extends Node2D

class_name State_2D

var state_machine:State_Machine = null
var entity:CharacterBody2D = null
var data:Node = null

var name_of_state:String

var states_to_which_I_can_travel:Array = []
var states_that_can_travel_to_me:Array = []
#Lista con todas las claves de los estados a los que este estado puede viajar.

func _add_state_to_the_machine(name_of_state:String, state:State_2D):
	state_machine.add_new_state_to_dictionary(name_of_state, state)

func action():
	assert(false, "¡El método 'action()' debe ser sobrescrito en la subclase!")
	
func action_of_end():
	#sobreescribe cuando quieras que el estado haga algo antes de ser cambiado.
	#Esta función se llama al salir del estado.
	pass

func add_a_state_to_which_I_can_travel(name_new_state:String):
	#La State Machine usará esta función para agregar un destino nuevo.
	states_to_which_I_can_travel.append(name_new_state)
