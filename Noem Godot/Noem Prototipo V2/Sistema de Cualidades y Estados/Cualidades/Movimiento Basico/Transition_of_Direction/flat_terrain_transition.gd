extends Sub_Quality

@onready var timer : Timer = $Timer

var accion_iniciada : bool = false

func _ready() -> void:
	name_of_subquality = "flat_terrain_transition" #<--- Reemplazar por Nombre de la SubCualidad.
	
	super._ready() #No Borrar ni modificar orden de llamado.
	
func action_of_start(): #Acción de Inicio de la SubCualidad
	data.direction_look *= -1
	entity.move_entity(0)
	timer.start()

func action(): #Acción de la SubCualidad, se ejecuta en bucle.

	#print("Aplicando Transicion\n")
	await timer.timeout
	#print("Termine la Transicion\n")
	action_finished()
		
	
func action_of_end(): #Acción de cierre de la SubCualidad.
	accion_iniciada = false

#--------------------------------------------------------------

#Métodos propios de la SubCualidad:


func _on_timer_timeout() -> void:
	pass
	#print("Timer Termino\n")
