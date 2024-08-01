extends TextureButton

@export var item_name := ""

func _on_pressed() -> void:
	$Checkmark.visible = !$Checkmark.visible

func save(current_data: Dictionary) -> void:
	current_data[item_name] = $Checkmark.visible

func load(current_data: Dictionary) -> void:
	if current_data.has(item_name):
		$Checkmark.visible = current_data[item_name]

func reset() -> void:
	$Checkmark.visible = false
