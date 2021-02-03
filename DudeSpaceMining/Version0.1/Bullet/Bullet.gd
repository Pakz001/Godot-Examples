extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletdirection
var bullettimeout = 1000

func _physics_process(delta):
	bullettimeout-=1
	if(bullettimeout<0):
		queue_free()
	var collidedObject = move_and_collide(bulletdirection)
	if(collidedObject):
		#collidedObject.get_collider().queue_free()
		queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
