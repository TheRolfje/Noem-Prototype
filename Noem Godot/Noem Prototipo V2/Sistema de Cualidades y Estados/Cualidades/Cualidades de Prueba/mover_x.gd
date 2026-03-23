extends Quality

@export var speed : int

func _ready() -> void:
	name_of_quality = &"mover_x"
	add_this_quality_to_the_manager()
	assing_this_quality_ass_default_quality()
	compartir_datos_con_las_subcualidades()

func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	if(data_entity.active_locomotional_state == &"l_state_a"):
		_start_this_sub_quality(&"derecha")
	elif(data_entity.active_locomotional_state == &"l_state_b"):
		_start_this_sub_quality(&"izquierda")
