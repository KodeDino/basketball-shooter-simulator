extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func switch_scene() -> void:
	get_tree().change_scene_to_packed(SceneManager.next_scene)
	animation_player.play("fade_to_normal")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_normal":
		queue_free()
