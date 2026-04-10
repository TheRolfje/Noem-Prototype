extends Node

#Biblioteca de todos los nombres de los estados para que godot los autocomplete.

class_name State_Names

class none_type:
	const none_name : StringName = &"none"

class Locomocion:
	
	const FLAT_TERRAIN : StringName = &"flat_terrain"
	const LOW_SLOPE : StringName = &"low_slope"
	const SUELO_INCLINACION_MEDIA : StringName = &"suelo_inclinacion_media"
	const SUELO_INCLINACION_ALTA : StringName = &"suelo_inclinacion_alta"
	const EN_EL_AIRE : StringName = &"en_el_aire"
	
class Proteccion:
	
	const PROTECCION_COMPLETA : StringName = &"proteccion_completa"
	const SOLO_CUERPO_PROTEGIDO : StringName = &"solo_cuerpo_protegido"
	const SOLO_CABEZA_PROTEGIDA : StringName = &"solo_cabeza_protegida"
	const DESPROTEGIDO : StringName = &"desprotegido"
	
class Fisico:
	
	const SANO : StringName = &"sano"
	const HERIDO : StringName = &"herido"
	const DESANGRANDOSE : StringName = &"desangrandose"
	const DERRIBADO : StringName = &"derribado"
	
class Emocional:
	
	#Programar una clase especifica para estados emocionales y agregarles un nivel de que
	#tan intensa es la emoción.
	
	const ENOJADO : StringName = &"enojado"
	const NEUTRO : StringName = &"neutro"
	const ALEGRE : StringName = &"alegre"
	const ASUSTADO : StringName = &"asustado"
	const TRISTE : StringName = &"triste"
	const TENSO : StringName = &"tenso"
	
	#ENOJADO: Aumenta el daño, velocidad, resistencia y la capacidad de romper guardia. Pero,
		#quita algo de punteria, y disminuye la probabilidad de matar un con disparo a quemarropa.
		#Cambia el patron de ataque a uno más agresivo, pero deja expuesto más.
	#Neutro: Estado normal en exploración sin demasiadas emociones. Se desactiva en combate.
	#Alegre: Normalmente visto en Malba, se usa para detectar ciertos comportamientos.
	#Asustado: Cambia el patrón de ataque a uno defensivo, o la intención de la Entidad a directamente Huir.
	#Triste: También para Malba.
	#Tenso: Nervioso, alerta. Modifica las animaciones más que nada. Falta revisar mejor.
	
class Sigilo:
	
	const EXPUESTO : StringName = &"expuesto"
	const DESCUBIERTO : StringName = &"descubierto"
	const ENCUBIERTO : StringName = &"encubierto"
	const SEMI_EXPUESTO : StringName = &"semi_expuesto"
	
	
