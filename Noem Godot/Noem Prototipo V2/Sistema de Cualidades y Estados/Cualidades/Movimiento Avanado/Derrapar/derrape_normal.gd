extends Sub_Quality

var derrape_activo : bool = false

@onready var timer : Timer = $Timer

func _ready() -> void:
	name_of_subquality = "derrape_normal" #<--- Reemplazar por Nombre de la SubCualidad.
	
	super._ready() #No Borrar ni modificar orden de llamado.
	
func action_of_start(): #Acción de Inicio de la SubCualidad
	print("Iniciando Derrape\n")
	derrape_activo = true
	timer.start(0.25)

func action(): #Acción de la SubCualidad, se ejecuta en bucle.
	entity.move_entity(400)
	
	if(not derrape_activo):
		print("Derrape Terminado\n")
		quality_owner.qualities_manager.change_active_quality("idle")
		#Esto va a ir a Idle Agachado.
	
func action_of_end(): #Acción de cierre de la SubCualidad.
	timer.stop()

#--------------------------------------------------------------

#Métodos propios de la SubCualidad:


func _on_timer_timeout() -> void:
	derrape_activo = false
