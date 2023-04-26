extends Node2D

var mirror_level = 300

# Called when the node enters the scene tree for the first time.
func duplicate_children():
	for platform in get_children():
		if platform != $Duplicates:
			add_mirrored(platform)

func change_child_property(path,property,value):
	var child = get_node(path)
	var duplicate = $Duplicates.get_node(path)
	print($Duplicates.get_children())
	child[property] = value
	duplicate[property] = value

func add_mirrored(node):
	var clone: Node2D
	if node.get("mirror_prefab") != null:
		var prefab = load(node.mirror_prefab)
		clone = prefab.instantiate()
		clone.transform = node.transform
		clone.name = node.name
	else:
		clone = node.duplicate()
	$Duplicates.add_child(clone)
	print(clone.get_path())
	clone.global_position.y = (mirror_level * 2) - node.position.y
	clone.position.x = node.position.x
	clone.scale *= -1
	return clone
