extends Area2D

var speed = 120
#var state = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = get_parent().get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			#state = "move"
			
			var temp = object.global_position - global_position
			temp.y = 0
			
			#if temp.normalized().x <= 5:
				#state = "attack"
			
			position.x += temp.normalized().x * delta * speed
