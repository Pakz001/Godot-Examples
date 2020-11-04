extends Area2D

var speed = 350
var steer_force = 100.0
var velocity = Vector2.ZERO	

func _physics_process(delta):
	var steer = Vector2.ZERO
	var desired = (get_global_mouse_position() - position).normalized() * speed
	steer = (desired - velocity).normalized() * steer_force	
	velocity += steer * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
