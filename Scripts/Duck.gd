extends Area2D

var speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = $Area2D.get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			position.x += (object.position.x - position.x) / 100
