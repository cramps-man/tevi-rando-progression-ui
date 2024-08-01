extends TextureRect

@export var item_name := ""
var count := 0

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				count += 1
				update_display_count()
			MOUSE_BUTTON_RIGHT:
				count -= 1
				update_display_count()

func update_display_count() -> void:
	$CountDisplay.text = str(count)

func save(current_data: Dictionary) -> void:
	current_data[item_name] = count

func load(current_data: Dictionary) -> void:
	if current_data.has(item_name):
		count = current_data[item_name]
	update_display_count()

func reset() -> void:
	count = 0
	update_display_count()
