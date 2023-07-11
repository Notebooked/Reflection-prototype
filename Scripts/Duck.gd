extends Area2D

var speed = 120
var timer = 0
var endTime = 3
var attacking = false

func attack():
	attacking = false
	
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attacking:
		timer += delta
		if timer >= endTime:
			attack()
	else:
		var collision = get_parent().get_overlapping_bodies()
		for object in collision:
			if object.name == "Player":
				var temp = object.global_position - global_position
				temp.y = 0
				
				if abs(temp.x) <= 5:
					print(temp)
					attacking = true
				else:
					print("move")
					position.x += temp.normalized().x * delta * speed
