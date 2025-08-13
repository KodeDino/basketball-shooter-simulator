extends CanvasLayer




func switch_scene() -> void:
	get_tree().change_scene_to_packed(SceneManager.next_scene)



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
