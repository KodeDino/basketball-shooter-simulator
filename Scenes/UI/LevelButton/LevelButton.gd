extends TextureButton

@export var target_scene: PackedScene
@export var level: String

@onready var level_label: Label = $MarginContainer/LevelLabel

func _ready() -> void:
	level_label.text = level

func _on_pressed() -> void:
	SceneManager.load_next_scene(target_scene)
