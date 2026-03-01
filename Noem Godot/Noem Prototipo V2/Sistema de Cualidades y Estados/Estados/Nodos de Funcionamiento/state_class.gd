extends Node

class_name State

var state_manager : State_Manager

var name_of_state : StringName #la clase "state_names" guarda todos los nombre de los estados como StringName.
var type_of_state : StringName #La clase State_Type guarda los nombres de los tipos de estado.
	
func _add_state_to_manager(name : StringName, type : StringName):
	state_manager.add_state_to_manager(self, name, type)
	
#Se sobreescriben al programar los estados, aunque quizas ni lo necesiten.
func action_of_start():
	pass
	
func action(): #Algunos estados ejecutan lógica continuamente o con el tiempo.
	pass
	
func action_of_end():
	pass
#----------------------------------------------------

#Después de esto ya irían los métodos propios de cada estado.
