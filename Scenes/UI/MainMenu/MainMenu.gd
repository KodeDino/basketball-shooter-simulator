extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_texture_button_pressed() -> void:
	audio_stream_player.play()
	await audio_stream_player.finished
	SceneManager.load_level_one_intro()


func _on_level_button_pressed() -> void:
	SceneManager.load_next_scene(load("res://Scenes/UI/LevelSelect/LevelSelect.tscn"))
