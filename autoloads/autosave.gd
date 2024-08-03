extends Timer

var autosave := false

func _ready() -> void:
	one_shot = true

func trigger_autosave() -> void:
	start(1.0)
