extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 3.5

var velocity = Vector2()
var rotation_dir = 0

const Speed = 100

var bullet := preload("res://Bullet/Bullet.tscn")

func get_input():
	rotation_dir = 0
	#velocity = Vector2()
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity += Vector2(-Speed/10, 0).rotated(rotation)
		
	if Input.is_action_pressed('up'):
		velocity += Vector2(Speed/10, 0).rotated(rotation)

	var current_speed = velocity.length()
	if(current_speed > Speed):
		velocity = velocity.normalized() * Speed
	if Input.is_action_just_pressed('shoot'):
		
		var bulletInstance = bullet.instance()
		bulletInstance.position = position+Vector2(40, 0).rotated(rotation)
		bulletInstance.position.y+=10
		bulletInstance.bulletdirection = Vector2(10, 0).rotated(rotation)
		get_tree().get_root().add_child(bulletInstance)

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func _ready():
	
	pass # Replace with function body.

func old_physics_process(delta):
	var direction = Vector2()
	
	rotation+=.05
	
	
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

