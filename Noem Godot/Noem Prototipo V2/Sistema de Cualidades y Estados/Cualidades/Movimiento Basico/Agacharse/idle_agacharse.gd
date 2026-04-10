extends Sub_Quality

var agachado_completado : bool = false

func _ready() -> void:
	name_of_subquality = "agachado_normal" #<--- Reemplazar por Nombre de la SubCualidad.
	
	super._ready() #No Borrar ni modificar orden de llamado.
	
func action_of_start(): #Acción de Inicio de la SubCualidad
	#entity.move_entity(0)
	pass

func action(): #Acción de la SubCualidad, se ejecuta en bucle.
	data.agachado = true
	
func action_of_end(): #Acción de cierre de la SubCualidad.
	pass

#--------------------------------------------------------------

#Métodos propios de la SubCualidad:
