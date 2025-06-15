extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_sprite: Sprite2D = $ArrowSprite


enum BasketballStates { Ready, Drag, Release }


var _state: BasketballStates = BasketballStates.Ready
var _start_position: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_position = position
	_arrow_scale_x = arrow_sprite.scale.x
	arrow_sprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
