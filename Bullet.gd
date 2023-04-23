extends KinematicBody2D

var speed = 750
var velocity = Vector2()

var despawn_bounds

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	despawn_bounds = abs(position.x) + 1000

func _physics_process(delta):
	if abs(position.x) > despawn_bounds or abs(position.y) > despawn_bounds:
		queue_free() #KILL YOURSELF
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		
		if collision.collider.name == "Player":
			queue_free()
		
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
