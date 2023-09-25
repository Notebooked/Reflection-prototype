extends CharacterBody2D

var acceleration = 500
var gravity = 20
var max_velocity = 390
var floor_deceleration = 0.6
var air_deceleration = 0.75

var jump_power = 500
var can_jump = false
var can_special_jump = false
var coyote_time = 0.1
var coyote_timer = 0

var dashing = false
var can_dash = false
var dash_time = 0.175
var dash_speed = 1400
var current_dash_time = 0.0
var dash_vertical_mult = 0.75
var dash_retain_velocity = Vector2.ZERO
var dash_direction = Vector2.ZERO

var direction = Vector2.ZERO

var mirrored: Sprite2D
var mirror_level = 300
var show_mirror = false
var can_enter_mirror_world = false

var in_mirror_world = false

var checkpoint = null

# Called when the node enters the scene tree for the first time.
func _ready():
	mirrored = $Mirrored
	set_up_direction(Vector2.UP)

func move(delta):
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
	
	move_and_slide()
		
	if (is_on_floor()) and velocity.y >= 0:
		velocity.y = 0
		can_jump = true
		can_special_jump = false
		coyote_timer = 0
	else:
		can_jump = false
		coyote_timer += delta
		
	if is_on_ceiling() and velocity.y < 0:
		velocity.y = 20
	
	if Input.is_action_just_pressed("jump"):
		if can_jump or coyote_timer < coyote_time:
			velocity.y = -jump_power
			can_jump = false
			coyote_timer = coyote_time
		elif can_special_jump == true:
			velocity.y = -jump_power
			can_special_jump = false
	
	if is_on_floor() and direction.x != 0:
		$WalkingParticles.emitting = true
		$WalkingParticles.direction.x = -direction.x
		
		$WalkingParticlesMirrored.emitting = true
		$WalkingParticlesMirrored.direction.x = -direction.x
	else:
		$WalkingParticles.emitting = false
		
		$WalkingParticlesMirrored.emitting = false

func start_dash():
	dashing = true
	can_dash = false
	current_dash_time = 0.0
	dash_direction = direction.normalized()
	
func dash(delta):
	current_dash_time += delta
	if current_dash_time >= dash_time:
		dashing = false
		for node in get_tree().get_nodes_in_group("passable"):
			node.enable_collision()
		return
	else:
		var move = dash_direction
		move.y *= dash_vertical_mult
		move *= dash_speed
		set_velocity(move)
		move_and_slide()
		if move.y > 0:
			velocity = move * Vector2(0.65,1)
		else:
			velocity = move * Vector2(0.65,0.4)
			
	if !in_mirror_world:
		for i in range(0, get_slide_collision_count()):
			var collision: KinematicCollision2D = get_slide_collision(i)
			if "breakable" in collision.get_collider().get_groups():
				collision.get_collider().destroy()
		for node in get_tree().get_nodes_in_group("passable"):
			node.enable_collision()
	else:
		for node in get_tree().get_nodes_in_group("passable"):
			node.disable_collision()
		
func switch_world():
	if can_enter_mirror_world:
		in_mirror_world = !in_mirror_world

func enter_mirror_section(new_mirror_level):
	can_enter_mirror_world = true
	
	mirror_level = new_mirror_level
	show_mirror = true
	$PlayerPlatform.enable_collisions()

func exit_mirror_section():
	in_mirror_world = false
	can_enter_mirror_world = false
	
	show_mirror = false
	$PlayerPlatform.disable_collisions()

func die():
	position = checkpoint

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

func _process(delta):
	process_input()

func _physics_process(delta):
	if dashing:
		dash(delta)
	else:
		move(delta)
	
	mirrored.global_position.y = mirror_level * 2 - global_position.y
	mirrored.visible = show_mirror
