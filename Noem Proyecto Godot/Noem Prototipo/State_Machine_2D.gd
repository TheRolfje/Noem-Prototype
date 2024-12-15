extends Node2D

var Entity:CharacterBody2D
var active_state:Node2D
var old_state:String
var states:Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	Entity = self.owner

func switch_state(name_state:String):
	old_state = active_state.name_of_state
	active_state = states[name_state]

func add_state(name_new_state:String, new_state:Node2D):
	states[name_new_state] = new_state

func assign_default_state(state:Node2D):
	active_state = state
	old_state = active_state.name_of_state
