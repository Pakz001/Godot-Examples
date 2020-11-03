extends Node2D

var Bullet = preload("res://Bullet.tscn")
export var speed = 200

var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO

	if Input.is_action_just_pressed("ui_right"):
		shoot()

func _physics_process(_delta):	
	get_input()
	
func shoot():
	var b = Bullet.instance()
	.add_child(b)
	b.position = Vector2(rand_range(0,640),100)
	var angle_pos = get_global_mouse_position().angle_to_point(b.position)
	b.rotation = angle_pos

