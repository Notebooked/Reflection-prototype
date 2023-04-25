extends Area2D

export var mirror_level: float
export(NodePath) onready var platforms = get_node(platforms) as Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	platforms.mirror_level = mirror_level
	platforms.duplicate_children()


func _body_entered(body):
	if body.name == "Player":
		print("Player entered")
		body.enter_mirror_section(mirror_level)


func _on_body_exited(body):
	if body.name == "Player":
		print("Player exited")
		body.exit_mirror_section()
