extends KinematicBody2D


var speed = 20
var gravity = 20

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	velocity.y += gravity
	
	move_and_slide(velocity)
