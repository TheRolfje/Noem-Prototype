extends Node

class_name Quality

#FALTA LAS CONEXIONES CON LOS NODOS DE LA ENTIDAD, COMO DATA, ANIMACIONES, ETC.
#(aunque no se bien si con un export común funcione, al ser clase padre)

@onready var active_sub_quality : Node2D = null

enum Sub_Qualities{ #Aca van todos los nombres de las SubCualidades de esta Cualidad.
	NONE            #Deben escribirse igual que los nombres de sus respectivos Nodos.
}                   #Ya que esos nombres son lo que se van a usar para Buscar el Nodo de la SC

func execute_quality(): #La SM ejecuta la Cualidad con este método.
	quality_start_action()
	
	choose_sub_quality()

	
func end_quality(): #Lo ejecuta la SM cuando cambia la Cualidad, para terminar con la actual.
	active_sub_quality = null #Siempre debe ejecutarse.
	
	quality_end_action() #Este es el método que las Cualidades sobreescriben.
	
func quality_start_action():
	pass
	
func quality_end_action():
	pass
	
func choose_sub_quality(): #Acá va la lógica para elegir que SubCualidad elegir.
	pass
	
func sub_quality_action(): #La SM ejecuta esto en bucle.
	active_sub_quality.action()

func start_this_sub_quality(new_sub_quality: String):
	
	if active_sub_quality: #Si es Null acá es porque es la primera SC que esta C eligió.
		if active_sub_quality.has_method("end_action"):
			active_sub_quality.end_action() #Si no es Null, primero termina la SC activa.
		else:
			push_warning("La SubCualidad no tiene método End_Action")
	active_sub_quality = get_node_or_null(new_sub_quality)
	
	if active_sub_quality:
		if active_sub_quality.has_method("start_action"):
			active_sub_quality.start_action()
		else:
			push_warning("La SubCualidad no tiene método Start_Action")
			
		if not active_sub_quality.has_method("action"):
			push_warning("La SubCualidad no tiene método Action")
			#Lo valiodo aca porque si no se validaría en bucle por la SM.
	else:
		push_warning("La SubCualidad no se encontró.")
	
