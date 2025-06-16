extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_trigger_area_body_entered(body: Node2D) -> void:
	if body is Basketball and !animated_sprite_2d.is_playing():
		animated_sprite_2d.play("hoop")
