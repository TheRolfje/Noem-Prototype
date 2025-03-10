extends Node2D

var noem:CharacterBody2D = null
var data:Node
var malba:CharacterBody2D
var movimiento:Node2D

func _ready() -> void:
	malba = self.owner
	movimiento = $"../Control_of_Skills/S_Movement"
	data = $"../Data"
	
	if(_Buscar_Nodo_Noem()):
		data.set_direction_move_x(1)
		
func seguimiento():
	var distancia = noem.global_position - malba.global_position
	
	if(distancia.x >= data.distancia_de_seguimiento and
	data.direction_look == noem.data.direction_look):
		data.set_direction_move(noem.data.direction_movement)
		movimiento.walk()
	else:
		malba.velocity.x = 0
		
	if(distancia.x >= data.distancia_de_seguimiento and not
	data.direction_look == noem.data.direction_look):
		data.direction_look *= (-1)
		

func _Buscar_Nodo_Noem():
	var noem_group = get_tree().get_nodes_in_group("Noem")  # Busca nodos en el grupo "jugador"
	if noem_group.size() > 0:
		noem = noem_group[0]  # Asigna la referencia al primer jugador encontrado
		print("Encontre a Noem")
		return true
	else:
		print("No encuentro a Noem")
		return false
