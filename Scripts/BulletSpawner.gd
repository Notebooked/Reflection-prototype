extends StaticBody2D

const Bullet = preload("res://Scenes/Bullet.tscn")
var speed = 200
var velocity = Vector2()

var cooldown = 1
var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > cooldown:
		time = 0.0
		
		shoot()

func shoot():
	var b = Bullet.instantiate()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
