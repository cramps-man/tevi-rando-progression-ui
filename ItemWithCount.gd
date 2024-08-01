extends TextureRect

@export var item_name := ""
var count := 0

func _on_up_button_pressed() -> void:
	count += 1
	update_display_count()

func _on_down_button_pressed() -> void:
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
