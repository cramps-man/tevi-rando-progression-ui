extends Control

var current_data := {}

func _ready() -> void:
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	current_data = JSON.parse_string(save_game.get_line())
	
	for child in $GridContainer.get_children():
		child.load(current_data)
	for child in $GridContainer2.get_children():
		child.load(current_data)

func _on_save_button_pressed() -> void:
	for child in $GridContainer.get_children():
		child.save(current_data)
	for child in $GridContainer2.get_children():
		child.save(current_data)

	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_line(JSON.stringify(current_data))

func _on_reset_button_pressed() -> void:
	$PopupMenu.popup()

func _on_popup_menu_id_pressed(id: int) -> void:
	if id == 0:
		for child in $GridContainer.get_children():
			child.reset()
		for child in $GridContainer2.get_children():
			child.reset()
