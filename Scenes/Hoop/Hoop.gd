extends Node2D

@onready var net: Area2D = $Net
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var net_drag: float = 0.0
@onready var score_area: Area2D = $ScoreArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	for body in net.get_overlapping_bodies():
		if body is Basketball:
			body.linear_velocity *= net_drag


func _on_net_body_entered(body: Node2D) -> void:
	if body is Basketball:
		animated_sprite_2d.play("hoop")	


func _on_score_area_body_entered(body: Node2D) -> void:
	if body is Basketball:
		if body.passed_through_hoop:
			ScoreManager.increment_score()
			SignalManager.emit_on_basketball_score()

			
func _on_hoop_trigger_area_body_entered(body: Node2D) -> void:
	if body is Basketball:
		if body.linear_velocity.y > 0:
			body.passed_through_hoop = true
