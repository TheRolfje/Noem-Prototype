extends Node

class_name Quality

#UNA CUALIDAD TAMBIEN ACTUA DE "SUBQUALITY_MANAGER". Quizas debería separarlo, pero bueno... funciona.

#Las cualidades sacan todos los datos para funcionar del Qualities Manager.
@export var qualities_manager : Qualities_Manager

#Y las guardan para que sus SubCualidades las saquen de aca:
@onready var entity : Entity = qualities_manager.entity
@onready var data_entity : data_humanoid = qualities_manager.data_entity
@onready var animations_entity : AnimationPlayer = qualities_manager.animations
#faltan nodos de control, sonidos y demás.
var datos_compartidos_con_las_subcualidades : bool = false
#------------------------------------------------------

#Estos exports sirven para que cuando un estado cambia durante la ejecución de una Cualidad,
#la Cualidad sepa si debe o no llamar a "choose_sub_quality()" en base al tipo de estado que
#cambió, ya que quizas no le importa y se llamaría por nada.
@export var lomocomotional_changes_affect_me : bool = false
@export var emotional_changes_affect_me : bool = false
@export var physical_changes_affect_me : bool = false
@export var protection_changes_affect_me : bool = false
@export var stealth_changes_affect_me : bool = false
#-------------------------------------------------------

#Si esta en True, la Cualidad se convierte en Cualidad Por Defecto.

@export var default_quality : bool = false

#Si o si tiene que haber una Cualidad Por Defecto. Si hay varias, se toma por defecto a la
#última asignada como tal (creo, xd)
#-------------------------------------------------------

#Por defecto todas las cualidades interrumpen la ejecución de cualidades constantes como Idle, Walk, Run, etc.
#para que se ignoren mientras una cualidad normal se está ejecutando.
#Si esto esta en False, ya no va a interrumpir eso, y por ende la Cualidad puede ser interrumpida por las
#Cualidades antes mencionadas. 
#Si es True, en el Action of Start se va a levantar la bandera de Action_in_course.

@export var interrumpir_ejecucion_constante: bool = true

#Además, si es true, cuando una Cualidad Termina su acción, debe de levantar manualmente la bandera:
#Action_Finish, que indica que la acción termino, permitiendo que la bandera de Action_in_Course se baje
#y permitiendo de nuevo que la "ejecución constante" pueda activar una nueva Cualidad.
#Si la Bandera Action_Finished nunca se levanta, la única forma, en teoría, de terminar una Cualidad es cuando
#otra Cualidad manual se quiera activar, pero no se cambiaria automaticamente por una de "ejecución constante".

var action_finished : bool = false #Se tiene que levantar a través del metodo "action_finished()" de la
									#clase Sub_Quality.
#------------------------------------------------------

#Esta variable sirve para indicar a la qualitis manager que permita la ejecución del método action
#SOLO una vez, y luego espere a que termine. Sirve para cualidades que no tienen ninguna acción continua
#y solo ejecutan algo y esperan a que termine. Cualidades con cualquier tipo de movimiento o acción
#que dependa de una ejecución continua no deberían levantar esta flag.

@export var one_shot_quality : bool = false

var _one_shot_action_started : bool = false #Si "one_shot" esta levantada, esta bandera se usa para indicar que la
#acción ya se inicio y que no se debe iniciar de nuevo. Se pone en false por si misma de nuevo al final de la
#acción.

#------------------------------------------------------

#Si es True, la Cualidad podrá ser interrumpida SOLAMENTE por las cualidades que aparecen en su lista de
#Cualidades Bloqueadas. Si es False (por defecto), la Cualidad puede ser interrumpida por TODAS las
#Cualidades, salvo por las Cualidades Bloqueadas.

@export var Invertir_Permisos_de_Interrupcion : bool = false

#----------------------------------------------------------

#Funcionamiento de las SubCualidades:
var _all_sub_qualities_in_this_quality : Dictionary[StringName, Sub_Quality]

var active_sub_quality : Sub_Quality = null
var old_active_sub_quality : StringName

var old_sub_quality_finished : bool = true
var new_sub_quality_initialized : bool = false

var default_sub_quality : StringName = &"none"
#---------------------------------------------------

#Datos de la Cualidad:
var name_of_quality : StringName = &"LessName"
#-----------------------------------------------

#Estados y Cualidades desde los que esta Cualidad no puede activarse.
var estados_locomocionales_bloqueados : Array = []
var estados_de_proteccion_bloqueados : Array = []
var estados_fisicos_bloqueados : Array = []
var estados_emocionales_bloqueados : Array = []
var estados_de_sigilo_bloqueados : Array = []
var cualidades_bloqueadas : Array = []
	
#--------------------------------------------------------

#Métodos que las Cualidades Sobreescriben:
func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar. Es llamado cuando la Cualidad se activa.
	pass 
	
#------------------------------------------------------------------------------

#Metodos de Funcionamiento de las Cualidades:

func _ready() -> void:
	add_this_quality_to_the_manager()
	compartir_datos_con_las_subcualidades()
	
	if(default_quality):
		assing_this_quality_ass_default_quality()
		
	if(default_sub_quality == null):
		push_error("NO SE ASIGNO NINGUNA SUBCUALIDAD POR DEFECTO PARA LA CUALIDAD: " + name_of_quality + "\n")


func add_this_quality_to_the_manager(): #Se llama en el Ready de toda Cualidad.
	qualities_manager.add_new_quality_to_dictionary(name_of_quality, self)

func initialize_quality(): #La SM inicia la Cualidad con este método.
	if interrumpir_ejecucion_constante:
		action_finished = false
		data_entity.block_detection_of_constant_qualities = true
	else:
		#Esto es un seguro. Si "interrumpir ejecución constante" es false, la cualidad JAMAS debería ser
		#one shot. Si alguien marca one shot, pero desmarca ejecución constante, esto lo corrije antes de
		#de ejecutar la acción de la cualidad.
		one_shot_quality = false
	
	await quality_start_action() #Primero se ejecuta la acción de inicio de la Cualidad.
	#print("Acción de inicio de Cualidad: " + name_of_quality + " terminada\n")
	#print("Iniciando elección de SubCualidad.\n")
	init_choose_sub_quality() #Después se elije e inica una Sub Cualidad.
	
func finish_quality(): #Lo ejecuta la SM cuando cambia la Cualidad.
	await _action_of_end_of_sub_quality() #Tengo miedo que esto genere condición de carrera
									#si esto se llama a mitad de la ejecución de la acción
									#de la SubCualidad. Aunque, no se si vaya a pasar.
	
	active_sub_quality = null
	
	await quality_end_action() #Este metodo se sobreescribe.
	
func assing_this_quality_ass_default_quality():
	qualities_manager.assign_this_quality_ass_default_quality(self)
	
#----------------------------------------------------------------
	
#Métodos de Funcionamiento de las SubCualidades:

func init_choose_sub_quality():
	choose_sub_quality()
	
	#Si cuando Choose_Sub_Quality termina, no se eligió ninguna SubCualidad para activar, entonces
	#esto activa la SubCualidad marcada como Por Defecto.
	if(new_sub_quality_initialized == false):
		push_error("NO SE ELIGIO NINGUNA SUBCUALIDAD PARA LA CUALIDAD: " + name_of_quality + "\n")
		_start_this_sub_quality(default_sub_quality)

#Cuando se decide que SubCualidad activar (Dentro de "choose_sub_quality()"),
#se inicia esa SubCualidad con este método.
func _start_this_sub_quality(new_sub_quality: StringName):
	#print("Cambiando a Sub Cualidad: " + new_sub_quality + "\n")
	#Cierra la SubCualidad activa e inicia una nueva.
	if(active_sub_quality == null or new_sub_quality != active_sub_quality.name_of_subquality):
		#Cierra la SubCualidad anterior y ejecuta la acción de inicio de una nueva.
		if (active_sub_quality != null): #Si es Null acá es porque es la primera SC que esta C eligió.
			await _action_of_end_of_sub_quality()
			
			old_active_sub_quality = active_sub_quality.name_of_subquality
		else:
			old_active_sub_quality = new_sub_quality
			
		active_sub_quality = _all_sub_qualities_in_this_quality[new_sub_quality]
		data_entity.active_sub_quality = active_sub_quality.name_of_subquality
		
		await _action_of_start_of_sub_quality()

func _sub_quality_action(): #La SM ejecuta esto en bucle.
	if(datos_compartidos_con_las_subcualidades):
		if(new_sub_quality_initialized and old_sub_quality_finished):
			await active_sub_quality.action()
		#else:
			#print("Intentando Ejecutar acción de la SubCualidad activa: " + active_sub_quality.name_of_subquality + "\n")


func _action_of_end_of_sub_quality():
	
	#print("Iniciando acción de fin de SubCualidad: " + active_sub_quality.name_of_subquality + "\n")
	old_sub_quality_finished = false
	await active_sub_quality.action_of_end()
	old_sub_quality_finished = true
	#print("Acción de fin de SubCualidad: " + active_sub_quality.name_of_subquality + " terminada\n")
	
	new_sub_quality_initialized = false

func _action_of_start_of_sub_quality():
	
	#print("Iniciando acción de inicio de SubCualidad: " + active_sub_quality.name_of_subquality + "\n")
	await active_sub_quality.action_of_start()
	new_sub_quality_initialized = true
	#print("Acción de inicio de SubCualidad: " + active_sub_quality.name_of_subquality + " terminada\n")

func add_subquality_to_the_quality_owner(subquality : Sub_Quality, name : StringName):
	if(name != &"none"):
		_all_sub_qualities_in_this_quality[name] = subquality
	else:
		push_error("LA SUBCUALIDAD NO TIENE NOMBRE. SE LE DEBE PONER NOMBRE ANTES DE LLAMAR A ESTE METODO.")
	
func compartir_datos_con_las_subcualidades():
	for subquality : Sub_Quality in get_children():
		subquality.entity = entity
		subquality.data = data_entity
		subquality.animations = animations_entity
		
	datos_compartidos_con_las_subcualidades = true
		
	
	
