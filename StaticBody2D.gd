extends StaticBody2D

const bulletScene = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()

func shoot():
	var bullet = bulletScene.instance()
	
	get_parent().add_child(bullet)
	# bullet.position = $Position2D.global_position
