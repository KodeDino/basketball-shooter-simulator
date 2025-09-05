extends Node

signal on_basketball_score
signal on_basketball_removed
signal on_dialogue_updated(data: Dictionary)
signal on_dialogue_finished
signal on_main_menu_button_clicked

func emit_on_basketball_score() -> void:
	on_basketball_score.emit()

func emit_on_basketball_removed() -> void:
	on_basketball_removed.emit()

# signal emitted with the updated dialogue data
func emit_on_dialogue_updated(data: Dictionary) -> void:
	on_dialogue_updated.emit(data)

func emit_on_dialogue_finished() -> void:
	on_dialogue_finished.emit()

func emit_on_main_menu_button_clicked() -> void:
	on_main_menu_button_clicked.emit()
