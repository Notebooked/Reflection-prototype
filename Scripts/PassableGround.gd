extends StaticBody2D

func enable_collision():
	$CollisionShape2D.disabled = false

func disable_collision():
	$CollisionShape2D.disabled = true
