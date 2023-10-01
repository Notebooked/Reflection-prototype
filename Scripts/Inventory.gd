extends HBoxContainer

@export var inventory_item_template: PackedScene;

func create_inventory_item(texture):
	var new_item = inventory_item_template.instantiate()
	self.add_child(new_item)
	new_item.texture = texture
