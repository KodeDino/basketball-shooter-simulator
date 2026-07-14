extends AnimatableBody2D

var tween: Tween
var tentacle_speed := 2.0
@export var start_position: Vector2
@export var end_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_tentacle()


func move_tentacle() -> void:
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", end_position, tentacle_speed)
	tween.tween_property(self, "position", start_position, tentacle_speed)
