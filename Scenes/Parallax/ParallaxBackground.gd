extends Parallax2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var parallax2DTexture: Texture2D
@export var autoScrollSpeed: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# calculate ratio between viewport and bg image
	var ratio = get_viewport_rect().size.y / parallax2DTexture.get_height()
	sprite_2d.texture = parallax2DTexture
	sprite_2d.scale = Vector2(ratio, ratio)
	repeat_size.x = parallax2DTexture.get_width() * ratio
	autoscroll.x = autoScrollSpeed
	

func stop_parallax() -> void:
	autoscroll.x = 0
