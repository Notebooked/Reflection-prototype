extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for platform in get_children():
		var clone: Node2D = platform.duplicate()
		add_child(clone)
		clone.global_position.y = 600 - platform.position.y
		clone.position.x = platform.position.x
