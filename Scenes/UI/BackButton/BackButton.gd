extends TextureButton

@export var back_to_scene: PackedScene


func _on_pressed() -> void:
	SceneManager.load_next_scene(back_to_scene)
