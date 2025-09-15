extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_over_label: Label = $GameOverLabel
@onready var button_container: Control = $ButtonContainer

func _ready() -> void:
	await animation_player.animation_finished
	game_over_label.show()
	animation_player.play("game_over")
	button_container.show()
	
	
func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	

func _on_main_menu_button_pressed() -> void:
	SignalManager.emit_on_main_menu_button_clicked()	
