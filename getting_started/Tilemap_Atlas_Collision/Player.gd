extends KinematicBody2D

const Speed = 300

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Vector2()
	var velocity = Speed * delta
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= velocity
	if Input.is_action_pressed("ui_right"):
		direction.x += velocity
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= velocity
	
	if Input.is_action_pressed("ui_down"):
		direction.y += velocity
		
	var collide = move_and_collide(direction)
	#if collide:
	#	print("collided with: ", collide.collider.name)
		#handle_collision(collide)

