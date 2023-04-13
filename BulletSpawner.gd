extends StaticBody2D

const Bullet = preload("res://Bullet.tscn")
var speed = 200
var velocity = Vector2()

func _process(delta):
	shoot()

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
