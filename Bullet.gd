extends KinematicBody2D

var speed = 750
var velocity = Vector2()

func _ready():
	$Timer.connect("timeout", self, "queue_free")
	$Timer.set_wait_time(1)
	$Timer.start()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	if abs(position.x) > despawn_bounds or abs(position.y) > despawn_bounds:
		queue_free() #KILL YOURSELF
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
