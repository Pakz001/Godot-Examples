extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	set_physics_process(true)

func _process(delta):
	#
	# Note that when the bullets leave the sreen they might need to be flushed also!
	#
	if Input.is_action_just_pressed("fire"):
		var bulletInstance = bullet.instance()
		bulletInstance.position = Vector2(position.x,position.y-50)
		get_tree().get_root().add_child(bulletInstance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-speed*delta,0))
	elif Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(speed*delta,0))
	
	
  
