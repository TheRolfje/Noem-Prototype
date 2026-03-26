extends State

func _ready() -> void:
	name_of_state = "none" #<--- Reemplazar por el nombre del estado.
	type_of_state = State_Type.NONE  #<--- Reemplazar NONE por el tipo de estado correcto.
	
	super._ready() #No borrar ni modificar posición
	
func action_of_start():
	pass
	
func action(): #Algunos estados ejecutan lógica continuamente o con el tiempo.
	pass
	
func action_of_end():
	pass
#----------------------------------------------------

#Después de esto ya irían los métodos propios de cada estado.
