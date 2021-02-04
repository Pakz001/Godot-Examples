extends KinematicBody2D


export (int) var speed = 200
export (float) var rotation_speed = 3.5

var velocity = Vector2()
var rotation_dir = 0
var banana=1
const Speed = 100

var bullet := preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		bulletInstance.position = position+Vector2(80, 0).rotated(rotation)
		bulletInstance.position.y+=10
		bulletInstance.bulletdirection = Vector2(10, 0).rotated(rotation)
		get_tree().get_root().add_child(bulletInstance)
		
func _physics_process(delta):
	
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
