extends Node

var system_emotions
var noem : Noem_Entity

func _ready() -> void:
	system_emotions = self.owner
	noem = system_emotions.noem
	
func Procces_Action(action : String):
	match noem.data.emotional_state:
		noem.data.emotions.NEUTRAL:
			pass
			
		noem.data.emotions.HAPPY:
			pass
			
		noem.data.emotions.ANGRY:
			pass
			
		noem.data.emotions.FEAR:
			pass
