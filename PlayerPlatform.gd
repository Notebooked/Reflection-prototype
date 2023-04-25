extends StaticBody2D

var player: KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()

func _process(delta):
	print($CollisionShape2D.disabled)
	var mirror_level = player.mirror_level
	global_position = Vector2(player.global_position.x, mirror_level)

func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
