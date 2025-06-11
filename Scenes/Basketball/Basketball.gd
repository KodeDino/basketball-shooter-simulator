extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animated_sprite_2d.play("basketball_rotate")
	animation_player.play("basketball_rotate")
	if Input.is_action_just_pressed("ui_up"):
		freeze = false


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
