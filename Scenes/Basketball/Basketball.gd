extends RigidBody2D

class_name Basketball

const MIN_CLAMP = Vector2(-20, 0)
const MAX_CLAMP = Vector2(0, 20)
const IMPULSE_MULTIPLIER = 25
const IMPULSE_MAX = 1500

# Trajectory preview constants
const TRAJECTORY_POINTS = 12
const TRAJECTORY_TIME_STEP = 0.05
const TRAJECTORY_ARROW_SCALE = 0.4


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_sprite: Sprite2D = $ArrowSprite


enum BasketballStates { Ready, Drag, Release }


var _state: BasketballStates = BasketballStates.Ready
var _start_position: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0

# Trajectory preview variables
var _trajectory_arrows: Array[Sprite2D] = []
var _gravity: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	

func setup() -> void:
	_start_position = position
	_arrow_scale_x = arrow_sprite.scale.x
	arrow_sprite.hide()
	_gravity = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)
	# TODO uncomment when special case is applied
	#setup_trajectory_arrows()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
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
	
	# TODO needs to have a condition for special levels
	# TODO uncomment when skill is used
	#update_trajectory_preview()
	
	
func update_arrow_scale() -> void:
	var impulse_length: float = calculate_impulse().length()
	var percentage: float = clamp(impulse_length / IMPULSE_MAX, 0.0, 1.0)
	arrow_sprite.scale.x = lerp(_arrow_scale_x, _arrow_scale_x * 2.5, percentage)
	arrow_sprite.rotation = (_start_position - position).angle()
	
	
func start_releasing() -> void:
	freeze = false
	arrow_sprite.hide()
	# TODO uncomment when special case is applied
	#hide_trajectory_arrows()
	var impulse = calculate_impulse()
	apply_central_impulse(impulse)
	
	
func calculate_impulse() -> Vector2:
	return _dragged_vector * -IMPULSE_MULTIPLIER


func setup_trajectory_arrows() -> void:
	# Create trajectory arrow sprites
	for i in range(TRAJECTORY_POINTS):
		var arrow: Sprite2D = Sprite2D.new()
		arrow.texture = arrow_sprite.texture
		arrow.scale = Vector2(TRAJECTORY_ARROW_SCALE, TRAJECTORY_ARROW_SCALE)
		arrow.hide()
		add_child(arrow)
		_trajectory_arrows.append(arrow)


func calculate_trajectory_point(initial_velocity: Vector2, time: float, start_pos: Vector2) -> Vector2:
	var x = initial_velocity.x * time
	var y = initial_velocity.y * time + 0.5 * _gravity * time * time
	return start_pos + Vector2(x - 10, y + 25)  # Offset arrows down by 8 pixels


func update_trajectory_preview() -> void:
	if _state != BasketballStates.Drag:
		hide_trajectory_arrows()
		return

	var initial_velocity = calculate_impulse()

	for i in range(TRAJECTORY_POINTS):
		var time = (i + 1) * TRAJECTORY_TIME_STEP
		var pos = calculate_trajectory_point(initial_velocity, time, _start_position)
		var next_pos = calculate_trajectory_point(initial_velocity, time + TRAJECTORY_TIME_STEP, _start_position)

		_trajectory_arrows[i].global_position = pos
		_trajectory_arrows[i].rotation = (next_pos - pos).angle()
		_trajectory_arrows[i].show()


func hide_trajectory_arrows() -> void:
	for arrow in _trajectory_arrows:
		arrow.hide()


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
	SignalManager.emit_on_basketball_removed()
	queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag") and _state == BasketballStates.Ready:
		change_state(BasketballStates.Drag)
