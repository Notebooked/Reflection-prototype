extends Camera2D

var cam_mode = "free"

var free_zoom_mult = 0.003

var min_zoom = 0.8
var max_zoom = 2.5
var zoom_threshold = 150

var target_zoom = Vector2.ONE
var zoom_lerp_weight = 0.2

var target_offset = Vector2.ZERO
var offset_lerp_weight = 0.125

var player: KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	
	target_offset = Vector2(player.position.x - 512, 0)
	
	offset = lerp(offset, target_offset, offset_lerp_weight)

func _2process(delta):
	global_position = Vector2(512,300)
	
	if cam_mode == "free":
		var dist = player.position.y #distance from top of screen
		
		if dist < zoom_threshold:
			print("IN THRESHOLD")
			target_zoom.y = 1.0 + (zoom_threshold - dist) * free_zoom_mult
			target_zoom.x = target_zoom.y
		else:
			target_zoom = Vector2.ONE
		
		target_offset = Vector2(player.position.x - 512, 0)
	
	zoom = lerp(zoom, target_zoom, zoom_lerp_weight)
	offset = lerp(offset, target_offset, offset_lerp_weight)
	
func _process(delta):
	global_position = Vector2(512,300)
	
	if cam_mode == "free":
		if !player.in_mirror_world:
			target_offset = Vector2(player.position.x - 512, player.position.y - 300)
		else:
			target_offset = Vector2(player.position.x - 512, -(player.position.y - 300))
	
	zoom = lerp(zoom, target_zoom, zoom_lerp_weight)
	offset = lerp(offset, target_offset, offset_lerp_weight)
