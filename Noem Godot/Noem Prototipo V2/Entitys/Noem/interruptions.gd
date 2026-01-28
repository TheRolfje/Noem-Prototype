extends Node

#Todo elemento del juego que quiera enviar una interrupción a Noem lo hace pora acá.
#Por ejemplo: Recibir un ataque.

@export var state_machine:State_Machine
@export var data:data_humanoid

signal travel_to_state(new_state:String)

func _ready() -> void:
	travel_to_state.connect(state_machine.new_state_signal)

func recive_interruption(name_of_interruption:String):
	#la lógica es que si llega una interrupción, mientras ese estado este activo solo se procesa
	#la lógica de ese estado y se ignora todo lo que pase en "_process". Quizás con Noem no tiene
	#tanto sentido por el Match, pero en otras entidades sí por su árbol de prioridades.
	#Mientras la interrupción esta activa, no procesas el árbol.
	
	if(state_machine.interruption_is_valid(name_of_interruption)):
		data.continue_the_process = false
		emit_signal("travel_to_state", name_of_interruption)
