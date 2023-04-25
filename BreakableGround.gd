extends StaticBody2D


func destroy():
	$Cobblestone.visible = false
	$CollisionShape2D.disabled = true
	$Particles2D.emitting = true
