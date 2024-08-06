extends Node

func set_window_size(multiplier: float) -> void:
	var resolution := get_viewport().get_visible_rect().size
	get_window().size = resolution * multiplier

func set_window_transparency(is_transparent: bool) -> void:
	get_window().transparent_bg = is_transparent
