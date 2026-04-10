extends CharacterBody2D

#Contiene los métodos de la Entidad que las cualidades y estados usan para hacer que la Entidad
#haga cosas, como moverse. Es como su "cuerpo físico".

class_name Entity

@export var data : data_humanoid
@export var state_manager : State_Manager
@export var qualities_manager : Qualities_Manager

func _ready() -> void:
	pass
	
func start_default_states():
	#Todas las Entidades tienen varios tipos de estados, algunos dependen del terreno, otros no.
	#Los estados que No dependen del terreno se asignan como default aca. Los que dependen del terreno
	#se asignan cuando la Entidad aparece en el nivel.
	state_manager.change_active_state(State_Names.Emocional.NEUTRO, State_Type.EMOTIONAL)
	state_manager.change_active_state(State_Names.Fisico.SANO, State_Type.PHYSICAL)
	
func move_entity(speed : int):
	self.velocity = data.direction_movement * speed
