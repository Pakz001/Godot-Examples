extends KinematicBody2D


#export var target = "Main/Player"
onready var target_node = get_node("/root/Main/Player")

func _physics_process(delta):
	
	rotation+=.1
	var collidedObject = move_and_collide(Vector2(0,0))
	if global_position.distance_to(target_node.global_position)<80:
		position -= Vector2(3, 0).rotated(target_node.rotation)
	if global_position.distance_to(target_node.global_position)<50:
		queue_free()
	if(collidedObject):
		#collidedObject.get_collider().queue_free()
		queue_free()	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
