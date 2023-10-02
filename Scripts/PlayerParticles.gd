extends Node2D

const start_direction = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dif = randf_range(-0.2,0.2)
	$WalkingParticles.direction.y = -start_direction - dif
	$WalkingParticlesMirrored.direction.y = start_direction + dif

func start_particles():
	$WalkingParticles.emitting = true
	$WalkingParticlesMirrored.emitting = true

func stop_particles():
	$WalkingParticles.emitting = false
	$WalkingParticlesMirrored.emitting = false

func set_x_direction(x_direction):
	$WalkingParticles.direction.x = x_direction
	$WalkingParticlesMirrored.direction.x = x_direction
