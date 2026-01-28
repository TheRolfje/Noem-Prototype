extends Node2D

class_name  Cube_Emotion

@export var velocity : float = 0
@export var sprite : Sprite2D

var direction:Vector2 = Vector2(0,0)

func _ready() -> void:
	add_to_group("EMOTIONAL_CUBE")

func _process(delta: float) -> void:
	position += direction * velocity * delta

enum Emotions {
	ROJO, #Ira
	AZUL, #Tristeza
	AMARILLO, #Alegría
	ROSA, #Amor, cariño,
	CELESTE, #Vergüenza
	VERDE, #Admiración, Seguridad.
	VIOLETA, #Miedo, Tensión.
	NARANJA, #Euforia
	NEGRO, #Vacío
	BLANCO, #Caos
	SIN_COLOR #Valor por defecto
	#Bienestar, paz: La barra de emoción se cierra.
}

var diccionario_colores : Dictionary = {
	Emotions.ROJO : Color8(255,30,30),
	Emotions.AZUL : Color8(30,54,255),
	Emotions.AMARILLO : Color8(255,255,28),
	Emotions.ROSA : Color8(255,189,189),
	Emotions.CELESTE : Color8(189,255,255),
	Emotions.VERDE : Color8(18,203,15),
	Emotions.VIOLETA : Color8(107,47,255),
	Emotions.NEGRO : Color8(0,0,0),
	Emotions.BLANCO : Color8(255,255,255)
}

var color_of_cube = null
	
func Set_Color_Emotion(color : Emotions):
	
	sprite.modulate = diccionario_colores[color]
	
	color_of_cube = diccionario_colores[color] #Se usa para que el Contenedor acumule una emocion de
						#este color y luego al liberar genere una del mismo color

func Send_Emotion(dir : int):
	if(color_of_cube == null):
		push_error("EL CUBO DE EMOCIÓN NO TIENE UN COLOR ASIGNADO")
		
	if(dir == 1):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
		
func Connect_with_Area(area : Area2D):
	area.connect("body_exited", Callable(self, "Give_Visibility"))
	
func Give_Visibility(body):
	if(body == self):
		self.sprite.visible = true
