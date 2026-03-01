extends State

func _ready() -> void:
	state_manager = get_parent()
	name_of_state = &"phy_state_a"
	_add_state_to_manager(name_of_state, State_Type.LOCOMOTIONAL)
	
#Se sobreescriben al programar los estados, aunque quizas ni lo necesiten.
func action_of_start():
	print("Ejecutando acción de inicio de : " + name_of_state + "\n")
	
func action(): #Algunos estados ejecutan lógica continuamente o con el tiempo.
	#print("Soy el PhyA, un estado fisico\n")
	pass
	
func action_of_end():
	print("Ejecutando acción de fin de : " + name_of_state + "\n")
#----------------------------------------------------

#Después de esto ya irían los métodos propios de cada estado.
