extends KinematicBody2D


var acceleration = 500
var gravity = 20
var max_velocity = 350
var deceleration = 0.8
var jump_power = 400

var velocity = Vector2.ZERO

var mirrored: Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	mirrored = $Mirrored

func process_input():
	if Input.is_action_pressed("left") and velocity.x > -max_velocity:
		velocity.x -= acceleration
		if velocity.x < -max_velocity:
			velocity.x = -max_velocity
	if Input.is_action_pressed("right") and velocity.x < max_velocity:
		velocity.x += acceleration
		if velocity.x > max_velocity:
			velocity.x = max_velocity
		
	if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		velocity.x *= deceleration
		
	if (Input.is_action_just_pressed("jump")):
		velocity.y = -jump_power

func _physics_process(delta):
	velocity.y += gravity
	
#	if (is_on_floor()):
#		velocity.y = 0
	process_input()
	
	move_and_slide(velocity)
	
	mirrored.global_position.y = 600 - position.y
