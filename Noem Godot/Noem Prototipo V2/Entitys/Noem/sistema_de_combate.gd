extends Node

#Gestiona todo lo referente al combate y conecta con los estados "TakeDamage" y "Attack"
#de la state machine. El estado "Attack" va cambiando su metodo action en función del
#ataque que se ejecuta, pero ese ataque se gestiona y crea aca.

@export var data:data_humanoid
@export var interruptions:Node

func recive_attack_object(attack:object_attack):
	data.attack_received = attack
	
	if(!data.Noem_es_Indestructible):
		process_attack()
	
func process_attack():
	#de momento solo detecta si Noem es o no intangible, o sea si esquivo o no.
	
	if(!data.intangible):
		#no esquivo el ataque
		interruptions.recive_interruption("TAKE_ATTACK")
	else:
		pass
		#hace algo si esquivo el ataque.
	
