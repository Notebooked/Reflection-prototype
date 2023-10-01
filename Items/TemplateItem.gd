extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			object.get_node("CanvasLayer/MarginContainer/Inventory").create_inventory_item($Sprite2D.texture);
			queue_free()
