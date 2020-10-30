extends Spatial

#This body3d is global since we use it from another function
var Body3D = KinematicBody.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# create our camera
	var camera = Camera.new()
	.add_child(camera)
	camera.translate(Vector3(0,0,2))
	# create our collision shape - we need to trigger the show
	# collision shapes from the debug dropdown menu to see it
	var coll = CollisionShape.new()
	coll.shape = SphereShape.new()
	Body3D.add_child(coll)
	.add_child(Body3D)
	#pass # Replace with function body.

func _physics_process(delta):
	# left and right cursors to move the collision shape on the screen.
	if Input.is_action_just_pressed("ui_right"):
		Body3D.translate(Vector3(0.1,0,0))
	if Input.is_action_just_pressed("ui_left"):
		Body3D.translate(Vector3(-0.1,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
