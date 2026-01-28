extends Node

@export var visores : Viewvers
@export var cube_builder : Cube_Builder

const actions :  = Actions.Actions_Loaded
var system_emotions : System_of_Emotions
var noem : Noem_Entity

const emotion_color = Cube_Emotion.Emotions

func _ready() -> void:
	system_emotions = self.owner
	noem = system_emotions.noem
	
func Procces_Action(action : int):
	
	visores.Oper_Viewver()
	
	match system_emotions.data.emotional_state:
		noem.data.emotions.NEUTRAL:
			Noem_Neutral(action)
			
		noem.data.emotions.HAPPY:
			pass
			
		noem.data.emotions.ANGRY:
			pass
			
		noem.data.emotions.FEAR:
			pass

func Noem_Neutral(action):
	match action:
		actions.DISPARO:
			cube_builder.Build_and_Send_Emotion_Cube(emotion_color.VIOLETA)
		actions.GOLPE:
			cube_builder.Build_and_Send_Emotion_Cube(emotion_color.ROJO)
		actions.SONIDO_MISTERIOSO:
			cube_builder.Build_and_Send_Emotion_Cube(emotion_color.AZUL)
		_:
			print("Otra accion")
		
