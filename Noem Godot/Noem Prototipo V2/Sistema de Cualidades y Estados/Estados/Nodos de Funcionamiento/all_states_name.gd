extends Node

#Biblioteca de todos los nombres de los estados para que godot los autocomplete.

class_name states_names

class Locomocion:
	
	const SUELO_PLANO : StringName = &"suelo_plano"
	const SUELO_INCLINACION_BAJA : StringName = &"suelo_inclinacion_baja"
	const SUELO_INCLINACION_MEDIA : StringName = &"suelo_inclinacion_media"
	const SUELO_INCLINACION_ALTA : StringName = &"suelo_inclinacion_alta"
	const EN_EL_AIRE : StringName = &"en_el_aire"
	
class Proteccion:
	
	const PROTECCION_COMPLETA : StringName = &"proteccion_completa"
	const SOLO_CUERPO_PROTEGIDO : StringName = &"solo_cuerpo_protegido"
	const SOLO_CABEZA_PROTEGIDA : StringName = &"solo_cabeza_protegida"
	const EXPUESTO : StringName = &"expuesto"
	
class Fisico:
	
	const SANO : StringName = &"sano"
	const HERIDO : StringName = &"herido"
	const DESANGRANDOSE : StringName = &"desangrandose"
	const DERRIBADO : StringName = &"derribado"
	
class Emocional:
	
	const ENOJADO : StringName = &"enojado"
	const NEUTRO : StringName = &"neutro"
	const ALEGRE : StringName = &"alegre"
	const ASUSTADO : StringName = &"asustado"
	const TRISTE : StringName = &"triste"
	
