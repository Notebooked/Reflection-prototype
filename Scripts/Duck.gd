extends Area2D

var speed = 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = $Area2D.get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			var temp = object.position - position
			temp.y = 0
			position.x += temp.normalized().x * delta * speed
