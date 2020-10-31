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


#
# This is from the visibility notifier2d. It is linked from the node tab
# and the screen exited line(clicked) to bullet. It frees the bullet from
# the game so it no longer requires resources.
#
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #remove our bullet since it no longer works
	#pass # Replace with function body.
