extends KinematicBody2D

var speed = 500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collidedObject = move_and_collide(Vector2(0,-speed*delta))
	if(collidedObject):
		collidedObject.get_collider().queue_free()
		queue_free()
