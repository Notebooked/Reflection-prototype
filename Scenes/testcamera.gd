extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = get_parent().get_parent().get_parent().get_parent().get_node("Camera2D").transform;
