extends Label

@onready var data : data_humanoid = $"../Data"

func mostrar_cualidad_activa():
	self.text = str(data.active_quality)
