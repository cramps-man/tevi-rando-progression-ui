extends Control

const save_messsage_scene := preload("res://save_message.tscn")

var current_data := {}

func _ready() -> void:
	Autosave.timeout.connect(_on_save_button_pressed)
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var data = JSON.parse_string(save_game.get_line())
	if data == null:
		return
	current_data = data
	
	if current_data.has("should_autosave"):
		Autosave.autosave = current_data.should_autosave
		update_autosave_button_text()
	if current_data.has("one_item_mode"):
		Globals.one_item_mode = current_data.one_item_mode
		update_oneitemmode_button_text()

	for child in $GridContainer.get_children():
		child.load(current_data)
	for child in $GridContainer2.get_children():
		child.load(current_data)

func _on_save_button_pressed() -> void:
	for child in $GridContainer.get_children():
		child.save(current_data)
	for child in $GridContainer2.get_children():
		child.save(current_data)
	
	current_data.should_autosave = Autosave.autosave
	current_data.one_item_mode = Globals.one_item_mode

	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_line(JSON.stringify(current_data))

	animate_save_message()

func _on_reset_button_pressed() -> void:
	$ResetPopupMenu.popup()

func _on_popup_menu_id_pressed(id: int) -> void:
	if id == 0:
		for child in $GridContainer.get_children():
			child.reset()
		for child in $GridContainer2.get_children():
			child.reset()

func _on_autosave_button_pressed() -> void:
	Autosave.autosave = !Autosave.autosave
	update_autosave_button_text()

func update_autosave_button_text() -> void:
	if Autosave.autosave:
		$AutosaveButton.text = "Autosave ON"
		$SaveButton.disabled = true
	else:
		$AutosaveButton.text = "Autosave OFF"
		$SaveButton.disabled = false

func animate_save_message() -> void:
	var save_message := save_messsage_scene.instantiate()
	add_child(save_message)
	save_message.animate_save_message($SaveButton.position)

func _on_default_size_button_pressed() -> void:
	ProjectUtils.set_window_size(1.0)

func _on_one_item_mode_button_pressed() -> void:
	%OneTimeModePopupMenu.position = get_last_exclusive_window().position
	%OneTimeModePopupMenu.popup()

func _on_one_time_mode_popup_menu_id_pressed(id: int) -> void:
	Globals.one_item_mode = !Globals.one_item_mode
	update_oneitemmode_button_text()
	for child in $GridContainer.get_children():
		child.set_all_lights()

func update_oneitemmode_button_text() -> void:
	if Globals.one_item_mode:
		%OneItemModeButton.text = "One Item Mode ON"
	else:
		%OneItemModeButton.text = "One Item Mode OFF"

func _on_settings_button_pressed() -> void:
	$SettingsWindow.position = get_window().position + Vector2i(-250, 500)
	$SettingsWindow.popup()

func _on_settings_window_close_requested() -> void:
	$SettingsWindow.hide()
