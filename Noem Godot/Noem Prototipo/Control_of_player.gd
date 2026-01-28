extends Node2D

var noem:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	noem = self.owner
	
	I_am_node_of_movement()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	noem.movement = Input.get_axis("Izquierda","Derecha")
	
	noem.state_machine.active_state.action()
	
	noem.move_and_slide()

func I_am_node_of_movement():
	noem.assign_node_of_movement(self)
