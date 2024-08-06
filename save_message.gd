extends Label

func animate_save_message(start_position: Vector2) -> void:
	position = start_position
	var tween := create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -25), 1.0)
	tween.finished.connect(func(): 
		queue_free()
	)
