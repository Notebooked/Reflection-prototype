extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			object.jumps_left += 1
			queue_free()
