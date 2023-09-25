extends Area2D

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			body.has_key = true
			queue_free()
