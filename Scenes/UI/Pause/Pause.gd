extends Control

@onready var pause_menu: Control = $PauseMenu


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	pause_menu.show()
