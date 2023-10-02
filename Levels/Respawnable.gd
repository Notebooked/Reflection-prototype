extends Node2D

var respawnables = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var dupe = child.duplicate()
		
		respawnables.append(dupe)

func respawn():
	for child in get_children():
		child.queue_free()
	
	for respawnable in respawnables:
		var dupe = respawnable.duplicate()
		
		add_child(dupe)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
