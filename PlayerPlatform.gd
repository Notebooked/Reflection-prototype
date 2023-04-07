extends StaticBody2D


var player: KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")

func _process(delta):
	position.x = player.position.x
