extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_game_button_pressed() -> void:
	hide_and_unpause()


func _on_main_menu_button_pressed() -> void:
	hide_and_unpause()
	SceneManager.load_main_menu()


func _on_retry_button_pressed() -> void:
	hide_and_unpause()
	get_tree().reload_current_scene()


func hide_and_unpause() -> void:
	hide()
	get_tree().paused = false
