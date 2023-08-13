extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		get_parent().remove_child(self)
		body.add_child(self)
