extends RigidBody2D


const MIN_CLAMP = Vector2(-60, 0)
const MAX_CLAMP = Vector2(0, 60)
const IMPULSE_MULTIPLIER = 20
const IMPULSE_MAX = 1500


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
	setup()
	

func setup() -> void:
	_start_position = position
	_arrow_scale_x = arrow_sprite.scale.x
	arrow_sprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_state()
	
	
func start_dragging() -> void:
	_drag_start = get_global_mouse_position()
	arrow_sprite.show()
	
	
func handle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(MIN_CLAMP, MAX_CLAMP)
	
	_dragged_vector = new_dragged_vector
	position = _start_position + _dragged_vector
	
	update_arrow_scale()
	
	
func update_arrow_scale() -> void:
	var impulse_length: float = calculate_impulse().length()
	var percentage: float = clamp(impulse_length / IMPULSE_MAX, 0.0, 1.0)
	arrow_sprite.scale.x = lerp(_arrow_scale_x, _arrow_scale_x * 2.5, percentage)
	arrow_sprite.rotation = (_start_position - position).angle()
	
	
func start_releasing() -> void:
	freeze = false
	arrow_sprite.hide()
	apply_central_impulse(calculate_impulse())
	
	
func calculate_impulse() -> Vector2:
	return _dragged_vector * -IMPULSE_MULTIPLIER

	
func change_state(new_state: BasketballStates) -> void:
	if _state == new_state:
		return
	
	_state = new_state
	
	match _state:
		BasketballStates.Drag:
			start_dragging()
		BasketballStates.Release:
			start_releasing()
	

func update_state() -> void:
	match _state:
		BasketballStates.Drag:
			handle_dragging()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag") and _state == BasketballStates.Drag:
		call_deferred('change_state', BasketballStates.Release)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag") and _state == BasketballStates.Ready:
		change_state(BasketballStates.Drag)
