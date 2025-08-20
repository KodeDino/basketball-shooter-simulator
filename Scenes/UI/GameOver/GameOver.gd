extends Control


func _on_retry_button_pressed() -> void:
	SignalManager.emit_on_retry_button_clicked()
	

func _on_main_menu_button_pressed() -> void:
	SignalManager.emit_on_main_menu_button_clicked()	
