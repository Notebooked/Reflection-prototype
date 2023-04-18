extends StaticBody2D

var player: KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()

func _process(delta):
	global_position = Vector2(player.position.x, 300)
