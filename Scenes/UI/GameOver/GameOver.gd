extends Control


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	

func _on_main_menu_button_pressed() -> void:
	SignalManager.emit_on_main_menu_button_clicked()	
