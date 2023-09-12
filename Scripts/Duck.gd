extends Area2D

var speed = 120
var endTime = 3

var player_dir = 0

var attacking = false
var attack_dist = 150
var attack_timer = 0
var attack_phase = 0
var attack_lunge_speed = 1000
var attack_start_wait_time = 1
var attack_lunge_time = 1.15
var attack_end_wait_time = 2

var attack_cooldown_timer = 0
var attack_cooldown = 2

var moving_speed = 0
var moving_decel = 0.95

func attack():
	attacking = false
	
	return

func attacking_behavior(delta):
	attack_timer += delta
	if attack_timer <= attack_start_wait_time:
		pass #PLAY READYING ANIMATION
	elif attack_timer <= attack_lunge_time:
		moving_speed = attack_lunge_speed * player_dir #PLAY LUNGING ANIMATION
	elif attack_timer <= attack_end_wait_time:
		moving_speed *= 0.5
		pass #play attack stopping animation
	else:
		attacking = false
		attack_timer = 0
		attack_cooldown_timer = 0

func moving_behavior(delta):
	var collision = get_parent().get_overlapping_bodies()
	for object in collision:
		if object.name == "Player":
			var temp = object.global_position - global_position
			temp.y = 0
			
			player_dir = temp.normalized().x
			
			if abs(temp.x) <= attack_dist and attack_cooldown_timer > attack_cooldown:
				attacking = true
			else:
				moving_speed = player_dir * speed
	
	position.x += moving_speed * delta
	moving_speed *= moving_decel

func correct_position():
	var bounds = get_parent().get_node("CollisionShape2D").shape.size.x / 2
	position.x = clamp(position.x,-bounds + $CollisionShape2D.shape.height / 2,bounds - $CollisionShape2D.shape.height / 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack_cooldown_timer += delta
	
	if attacking:
		attacking_behavior(delta)
	else:
		moving_behavior(delta)
	
	position.x += moving_speed * delta
	moving_speed *= moving_decel
	
	correct_position()
