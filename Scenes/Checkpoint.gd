extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.checkpoint = position
		queue_free() # kill yourself
