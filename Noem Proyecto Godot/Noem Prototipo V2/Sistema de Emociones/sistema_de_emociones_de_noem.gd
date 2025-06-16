#Cuando una señal de acción es recibida, esta se envía al procesador,
#quien procesa que emoción mostrar por el visor, enviando la señal al visor. El visor se
#conecta con el nodo de contención, enviando la señal de si se contuvo o no la emoción.
#El nodo de contención se encarga de acumularla o liberarla al entrar en modo respiración,
#enviando la señal al nodo visor para mostrar el visor ampliado.

extends Node2D

var procesador
var noem : Noem_Entity

enum Actions {DISPARO, GOLPE, SONIDO_MISTERIOSO, SONIDO_NATURALEZA,
			SITUACION_ALEGRE, }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	procesador = $Procesador
	noem = self.owner
	
func Receive_Action(action : String):
	procesador.Procces_Action(action)
