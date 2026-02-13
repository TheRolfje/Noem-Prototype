extends Node

class_name State

@export var state_manager : State_Manager

var name_of_state : StringName #la clase "state_names" guarda todos los nombre de los estados como StringName.
var type_of_state : StringName #La clase State_Type guarda los nombres de los tipos de estado.
	
func _agregar_estado_al_manager(name : StringName, type : State_Type):
	pass
	
#Se sobreescriben al programar los estados, aunque quizas ni lo necesiten.
func action_of_start():
	pass
	
func action_of_end():
	pass
#----------------------------------------------------

#Después de esto ya irían los métodos propios de cada estado.
