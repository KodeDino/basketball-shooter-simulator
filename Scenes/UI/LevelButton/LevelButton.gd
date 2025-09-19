extends TextureButton

@export var target_scene: PackedScene
@export var level: String

@onready var level_label: Label = $MarginContainer/LevelLabel

func _ready() -> void:
	if is_level_unlocked(int(level)):
		level_label.text = level
	else:
		level_label.hide()
		set_locked_state(true)


func _on_pressed() -> void:
	SceneManager.load_next_scene(target_scene)


func is_level_unlocked(level_num: int) -> bool:
	return level_num <= ScoreManager._highest_unlocked_level


func set_locked_state(locked: bool) -> void:
	disabled = locked
