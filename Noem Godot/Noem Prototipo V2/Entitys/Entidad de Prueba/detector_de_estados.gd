extends Node2D

#CONVERTIR ESTO EN ESCENA CON MÁS UTILIDAD. ES UNA VERSION BETA.
#Detecta el terreno en el que está la Entidad y cambia el estado locomocional en consecuencia.

@export var state_manager : State_Manager

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Activador_de_Estado")):
		var activador := body as activador_de_estado
		
		state_manager.change_active_state(activador.nombre, activador.tipo)
