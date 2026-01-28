extends CharacterBody2D

class_name Noem_V1

var vida:int = 100
@export var speed:int = 100
var direction:bool = true #si es true, Noem mira a la derecha, si es false, a la izquierda.
var movement:float

var Node_Of_Movement:Node2D

var animacion_en_reproduccion:AnimationNodeStateMachinePlayback
#var direction:bool = true #si direction es true, Noem se mueve hacia la derecha, false es izquierda

var state_machine:Node2D

func _ready():
	animacion_en_reproduccion = $Sprite_Noem_V1/Control_de_animaciones.get("parameters/Noem_Animation_StateMachine/playback")
	$Sprite_Noem_V1/Control_de_animaciones.active = true
	
	state_machine = $State_Machine
	
func assign_node_of_movement(node_of_movement:Node2D):
	Node_Of_Movement = node_of_movement
