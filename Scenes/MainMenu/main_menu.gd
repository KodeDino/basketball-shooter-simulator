extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
const LEVEL_BASE = preload("res://Scenes/Levels/LevelBase.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	audio_stream_player.play()
	await audio_stream_player.finished
	SceneManager.load_level_base()
