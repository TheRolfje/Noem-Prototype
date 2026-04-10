extends Sub_Quality

func _ready() -> void:
	name_of_subquality = "deslizarse_pendiente" #<--- Reemplazar por Nombre de la SubCualidad.
	
	super._ready() #No Borrar ni modificar orden de llamado.
	
func action_of_start(): #Acción de Inicio de la SubCualidad
	pass

func action(): #Acción de la SubCualidad, se ejecuta en bucle.
	pass
	
func action_of_end(): #Acción de cierre de la SubCualidad.
	pass

#--------------------------------------------------------------

#Métodos propios de la SubCualidad:
