extends Camera2D

var player: CharacterBody2D

var target_position: Vector2

func _ready():
	player = get_parent()

func _physics_process(delta):
	if !player.in_mirror_world:
		target_position = player.global_position
	else:
		target_position = player.get_node("Mirrored").global_position
	
	global_position = lerp(global_position, target_position, 0.125)
