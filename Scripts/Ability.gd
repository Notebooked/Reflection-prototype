extends Area2D

func ability_action(player):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collisions = get_overlapping_bodies()
	for object in collisions:
		if object.name == "Player":
			ability_action(object)
			queue_free()
