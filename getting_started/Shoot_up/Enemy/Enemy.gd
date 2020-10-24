extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	move_and_collide(Vector2(speed*delta,0))
	if(position.x>get_viewport().size.x):
		speed = -speed
	if(position.x<0):
		speed = -speed
		
