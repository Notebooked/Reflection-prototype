extends KinematicBody2D

var acceleration = 500
var gravity = 20
var max_velocity = 390
var floor_deceleration = 0.6
var air_deceleration = 0.75

var jump_power = 500
var jumps_left = 2

var velocity = Vector2.ZERO

var dashing = false
var can_dash = true
var dash_time = 0.175
var dash_speed = 1200
var current_dash_time = 0.0
var dash_vertical_mult = 0.75
var dash_retain_velocity = Vector2.ZERO
var dash_direction = Vector2.ZERO

var direction = Vector2.ZERO

var mirrored: Sprite
var mirror_level = 300
var show_mirror = true

var in_mirror_world = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mirrored = $Mirrored

func move():
	velocity.y += gravity
	
	if is_on_floor():
		velocity.x *= floor_deceleration
	else:
		if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
			velocity.x *= air_deceleration
	
	if direction.x == -1 and velocity.x > -max_velocity:
		velocity.x -= acceleration
		if velocity.x < -max_velocity:
			velocity.x = -max_velocity
	if direction.x == 1 and velocity.x < max_velocity:
		velocity.x += acceleration
		if velocity.x > max_velocity:
			velocity.x = max_velocity
			
	if (Input.is_action_just_pressed("jump") and jumps_left > 0):
		velocity.y = -jump_power
		jumps_left -= 1
	
	move_and_slide(velocity, Vector2.UP)
		
	if is_on_floor():
		velocity.y = 0
		jumps_left = 2
		can_dash = true
	if is_on_ceiling():
		velocity.y = 20

func start_dash():
	dashing = true
	can_dash = false
	current_dash_time = 0.0
	dash_direction = direction.normalized()
	
func dash(delta):
	current_dash_time += delta
	if current_dash_time >= dash_time:
		dashing = false
	else:
		var move = dash_direction
		move.y *= dash_vertical_mult
		move *= dash_speed
		move_and_slide(move)
		if move.y > 0:
			velocity = move * Vector2(0.65,1)
		else:
			velocity = move * Vector2(0.65,0.4)

func switch_world():
	in_mirror_world = !in_mirror_world

func process_input():
	if Input.is_action_just_pressed("switch_world"):
		switch_world()
	
	direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if in_mirror_world:
		direction.y *= -1
	
	if direction != Vector2.ZERO and Input.is_action_just_pressed("dash") and can_dash and not dashing:
		start_dash()

func _physics_process(delta):
	process_input()
	
	if dashing:
		dash(delta)
	else:
		move()
	
	mirrored.global_position.y = (mirror_level * 2) - position.y
	mirrored.visible = show_mirror
