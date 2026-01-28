extends Node2D

var entity:CharacterBody2D
@export var data:Node

func _ready() -> void:
	entity = self.owner
