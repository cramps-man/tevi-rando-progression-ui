extends TextureButton

const light_scene := preload("res://item_nodes/Light.tscn")

@export var item_name := ""
@export var number_of_lights := 1
var current_lights_on := 0

func _ready() -> void:
	for i in max_num_lights():
		var light := light_scene.instantiate()
		$NumberOfLights.add_child(light)
	set_all_lights()

func max_num_lights() -> int:
	if Globals.one_item_mode:
		return 1
	else:
		return number_of_lights

func save(current_data: Dictionary) -> void:
	current_data[item_name] = current_lights_on

func load(current_data: Dictionary) -> void:
	if current_data.has(item_name):
		current_lights_on = current_data[item_name]
		set_all_lights()

func reset() -> void:
	current_lights_on = 0
	set_all_lights()

func set_all_lights() -> void:
	for child in $NumberOfLights.get_children():
		child.queue_free()
		$NumberOfLights.remove_child(child)
	for i in max_num_lights():
		var light := light_scene.instantiate()
		$NumberOfLights.add_child(light)
	current_lights_on = clampi(current_lights_on, 0, max_num_lights())
	for i in current_lights_on:
		$NumberOfLights.get_child(i).turn_on()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if current_lights_on < max_num_lights():
					current_lights_on += 1
					set_all_lights()
			MOUSE_BUTTON_RIGHT:
				if current_lights_on > 0:
					current_lights_on -= 1
					set_all_lights()
		Autosave.trigger_autosave()
