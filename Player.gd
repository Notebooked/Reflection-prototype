extends KinematicBody2D

var acceleration = 500
var gravity = 20
var max_velocity = 350
var deceleration = 0.8
var jump_power = 400

var velocity = Vector2.ZERO

var jumps_left = 2

var dashing = false
var dash_time = 0.35
var dash_speed = 700
var current_dash_time = 0.0
var dash_vertical_mult = 0.8
var dash_retain_velocity = Vector2.ZERO
var dash_direction = Vector2.ZERO

var direction = Vector2.ZERO

var mirrored: Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	mirrored = $Mirrored

func move():
	velocity.y += gravity
	
	if direction.x == -1 and velocity.x > -max_velocity:
		velocity.x -= acceleration
		if velocity.x < -max_velocity:
			velocity.x = -max_velocity
	if direction.x == 1 and velocity.x < max_velocity:
		velocity.x += acceleration
		if velocity.x > max_velocity:
			velocity.x = max_velocity
	
	if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		velocity.x *= deceleration
			
	if (Input.is_action_just_pressed("jump") and jumps_left > 0):
		velocity.y = -jump_power
		jumps_left -= 1
	
	move_and_slide(velocity, Vector2.UP)
		
	if (is_on_floor()):
		velocity.y = 0
		jumps_left = 2

func start_dash():
	dashing = true
	current_dash_time = 0.0
	dash_direction = direction
	
func dash(delta):
	current_dash_time += delta
	if current_dash_time >= dash_time:
		dashing = false
	else:
		var move = dash_direction
		move.y *= dash_vertical_mult
		move *= dash_speed
		move_and_slide(move)
		velocity = move * 0.8 * Vector2(1.2, 0.5)

func process_input():
	direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_just_pressed("dash"):
		start_dash()

func _physics_process(delta):
	process_input()
	
	if dashing:
		dash(delta)
	else:
		move()
	
	mirrored.global_position.y = 600 - position.y
