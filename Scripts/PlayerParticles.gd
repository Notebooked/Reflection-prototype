extends Node2D

const start_direction = 0.3

var player: CharacterBody2D

func _ready():
	player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dif = randf_range(-0.2,0.2)
	$WalkingParticles.direction.y = -start_direction - dif
	$WalkingParticlesMirrored.direction.y = start_direction + dif
	
	$WalkingParticlesMirrored.visible = player.show_mirror
	
	if player.direction.x == 0 or !player.is_on_floor():
		$WalkingParticles.emitting = false
		$WalkingParticlesMirrored.emitting = false
	else:
		$WalkingParticles.emitting = true
		$WalkingParticlesMirrored.emitting = player.show_mirror
		set_x_direction(-player.direction.x)

func set_x_direction(x_direction):
	$WalkingParticles.direction.x = x_direction
	$WalkingParticlesMirrored.direction.x = x_direction
