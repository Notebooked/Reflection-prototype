extends StaticBody2D

var closing = false
var closing_speed = 2

var start_scale = 0
const starting_scale = 128

func _ready():
	start_scale = $CollisionShape2D.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "Player":
			if body.has_key:
				closing = true
	
	if closing:
		if $Sprite2D.scale.x <= 0:
			closing = false
			
			$Sprite2D.visible = false
			$CollisionShape2D.disabled = true
		else:
			$CollisionShape2D.scale.x -= closing_speed * delta
			$CollisionShape2D.position.x -= closing_speed * delta * starting_scale * 0.5
			
			$Sprite2D.scale.x -= closing_speed * delta
			$Sprite2D.position.x -= closing_speed * delta * starting_scale * 0.5
