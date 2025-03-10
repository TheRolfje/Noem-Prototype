extends Node2D

@export var Entity:CharacterBody2D
@export var state_machine:Node2D
@export var data:Node

signal travel_to_state(new_state:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	travel_to_state.connect(state_machine.new_state_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	data.set_direction_move_x(Input.get_axis("ui_left","ui_right"))
	
	match state_machine.active_state.name_of_state:
		"IDLE":
			if(data.direction_movement.x != 0 and Input.is_action_pressed("shift")):
				emit_signal("travel_to_state", "RUN")
			
			if(data.direction_movement.x != 0):
				emit_signal("travel_to_state", "WALK")
		"WALK":
			if(data.direction_movement.x == 0):
				emit_signal("travel_to_state", "IDLE")
			
			if(Input.is_action_pressed("shift")):
				emit_signal("travel_to_state", "RUN")
		"RUN":
			if(data.direction_movement.x == 0):
				emit_signal("travel_to_state", "IDLE")
			
			if(data.direction_movement.x != 0 and not Input.is_action_pressed("shift")):
				emit_signal("travel_to_state", "WALK")
