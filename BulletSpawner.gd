extends StaticBody2D

const bulletScene = preload("res://Bullet.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()

func shoot():
	var bullet = bulletScene.instance()
	
	get_parent().add_child(bullet)
