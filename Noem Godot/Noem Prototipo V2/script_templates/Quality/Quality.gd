extends Quality

#Falta agregar todos los datos que una cualidad necesita, como su nombres, y demás.
#Hay un tema con la SM que voy a tener que modificar, por que la lógica anterior
#era de que la SM sistenía todo, y los estados chupaban datos de ahí.
#Ahora quiero que las Cualidades resivan sus datos de forma autonoma, y la SM
#solo coordina cual usar, así que la plantilla de Cualidades ironicamente
#necesita menos, ya que de los Exports se encarga la clase padre.

func _ready() -> void:
	super._ready() #Si o si debe llamar al ready de la clase Quality.

func quality_start_action(): #Acción de inicio de la Cualidad.
	pass
	
func quality_end_action(): #Cierre de la Cualidad (normalmente para recetearla para un siguiente uso)
	pass
	
func choose_sub_quality(): #Logica para elegir que SubCualidad usar.
	pass
