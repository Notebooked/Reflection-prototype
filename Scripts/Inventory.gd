extends HBoxContainer

@export var inventory_item_template: PackedScene;

var items = {}

func create_inventory_item(texture, item_name):
	var new_item = inventory_item_template.instantiate()
	self.add_child(new_item)
	new_item.texture = texture
	
	items[item_name] = new_item

func has_item(item_name):
	return item_name in items.keys()

func remove_item(item_name):
	items[item_name].queue_free()
	
	items.erase(item_name)

func reset():
	for item_name in items.keys():
		remove_item(item_name)
