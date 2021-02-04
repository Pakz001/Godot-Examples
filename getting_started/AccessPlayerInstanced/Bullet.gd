extends KinematicBody2D


var bulletdirection
var bullettimeout = 1000
var rotval = 0.1

# this allows us to acces the player using target_node
onready var target_node = get_node("/root/Player")

func _physics_process(delta):
	
	#
	# Here we modify the player
	#
	if rotval>0:
		target_node.rotation+=rotval
		rotval-=0.01
	
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
