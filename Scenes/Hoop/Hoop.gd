extends Node2D

@onready var net: Area2D = $Net
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var score_area: Area2D = $ScoreArea
@onready var timer_node: Timer = $Timer

@export var net_drag: float = 0.0
@export var start_position: Vector2
@export var end_position: Vector2
@export var special_level: bool
@export var hoop_speed:= 2.0
@export var timeout_second: float = 0.0
@export var should_hoop_move: bool = false

var bodies_in_top_trigger: Array = []
var tween: Tween


func _ready() -> void:
	SignalManager.on_instruction_next_button_pressed.connect(_on_instruction_next_button_pressed)
	timer_node.timeout.connect(_on_timer_timeout)
	if should_hoop_move:
		move_hoop()

func _physics_process(_delta: float) -> void:
	for body in net.get_overlapping_bodies():
		if body is Basketball:
			body.linear_velocity *= net_drag


func _on_instruction_next_button_pressed() -> void:
	if special_level:
		if timeout_second != 0.0:
			# Start the timer and wait for it to timeout before moving
			timer_node.start(timeout_second)
		else:
			# No delay, start moving immediately
			move_hoop()


func _on_timer_timeout() -> void:
	move_hoop()


func _on_net_body_entered(body: Node2D) -> void:
	if body is Basketball:
		animated_sprite_2d.play("hoop")	


func _on_score_area_body_entered(body: Node2D) -> void:
	# If the ball enters the score area AND it's currently in the top trigger, it's a valid goal.
	if body is Basketball and bodies_in_top_trigger.has(body):
		ScoreManager.increment_score()
		SignalManager.emit_on_basketball_score()
		
		# Remove the ball from the list so it can't score again.
		bodies_in_top_trigger.erase(body)

			
func _on_hoop_trigger_area_body_entered(body: Node2D) -> void:
	if body is Basketball and not bodies_in_top_trigger.has(body):
		bodies_in_top_trigger.append(body)


func _on_hoop_trigger_area_body_exited(body: Node2D) -> void:
	if body is Basketball and bodies_in_top_trigger.has(body):
		bodies_in_top_trigger.erase(body)
		

func move_hoop() -> void:
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", end_position, hoop_speed)
	tween.tween_property(self, "position", start_position, hoop_speed)
