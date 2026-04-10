extends Quality

@export var speed : int

func _ready() -> void:
	name_of_quality = &"mover_x"
	
	super._ready()

func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	if(data_entity.active_locomotional_state == State_Names.Locomocion.FLAT_TERRAIN):
		_start_this_sub_quality(&"derecha")
	elif(data_entity.active_locomotional_state == State_Names.Locomocion.LOW_SLOPE):
		_start_this_sub_quality(&"izquierda")
