extends TextureRect

func toggle() -> void:
	if modulate.a == 1.0:
		turn_off()
	else:
		turn_on()

func turn_on() -> void:
	modulate.a = 1.0

func turn_off() -> void:
	modulate.a = 0.5
