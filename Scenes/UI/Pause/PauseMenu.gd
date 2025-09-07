extends Control


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
