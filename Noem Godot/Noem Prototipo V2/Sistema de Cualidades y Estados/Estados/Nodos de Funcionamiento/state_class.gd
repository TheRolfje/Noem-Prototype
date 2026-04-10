extends Node

class_name State

var state_group : states_group

var name_of_state : StringName = &"none"#la clase "state_names" guarda todos los nombre de los estados como StringName.
var type_of_state : StringName = &"none"#La clase State_Type guarda los nombres de los tipos de estado.

var entity : Entity
var data : data_humanoid

func _ready() -> void:
	state_group = get_parent()
	
	if(name_of_state != &"none"):
		if(type_of_state != &"none"):
			_add_state_to_manager()
		else:
			push_error("EL ESTADO NO TIENE TIPO\n")
	else:
		push_error("EL ESTADO NO TIENE NOMBRE\n")

func _add_state_to_manager():
	#El grupo funciona como embudo, vos no cargas estado por estado como hijo del
	#manager, cargas la escena de un grupo entero.
	state_group._add_state_to_manager(self)
	
#Se sobreescriben al programar los estados, aunque quizas ni lo necesiten.
func action_of_start():
	pass
	
func action(): #Algunos estados ejecutan lógica continuamente o con el tiempo.
	pass
	
func action_of_end():
	pass
#----------------------------------------------------

#Después de esto ya irían los métodos propios de cada estado.
