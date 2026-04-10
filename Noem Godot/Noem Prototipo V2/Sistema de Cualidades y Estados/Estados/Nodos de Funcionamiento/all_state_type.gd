extends Node

class_name State_Type

const LOCOMOTIONAL : StringName = &"locomotional"
const EMOTIONAL : StringName = &"emotional"
const PROTECTION : StringName = &"protection"
const PHYSICAL : StringName = &"physical"
const STEALTH : StringName = &"stealth"
const NONE : StringName = &"none"

static func type_is_valid(type : StringName):
	var valid_types = [
		LOCOMOTIONAL,
		EMOTIONAL,
		PHYSICAL,
		PROTECTION,
		STEALTH
	]
	
	return valid_types.has(type) #Si el StringName no es un type valido, retorna false.
