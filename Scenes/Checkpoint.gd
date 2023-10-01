extends Area2D

func _on_body_entered(body):
	print("god")
	
	if body.name == "Player":
		body.checkpoint = position
		queue_free() # kill yourself

func _draw():
	draw_line(Vector2(0,1000),Vector2(0,-1000),Color.BLACK)
