extends Node2D

# We set up these variables, one for the icon and one for the character
var icon = preload("res://icon.png")
var character = KinematicBody2D.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Here we create the sprite
	var sprite = Sprite.new()
	sprite.set_texture(icon)
	character.add_child(sprite)
	.add_child(character)
	
	# Here we create the timer
	var timer = Timer.new()
	timer.set_wait_time(.5) #Every half second interval
	timer.autostart = true # start our timer
	.add_child(timer) # add it to the scene
	timer.connect("timeout",self,"When_timeout") # run this function when timeout
	
	pass # Replace with function body.

func When_timeout():
	#update our sprite its position on the screen.
	randomize()	
	character.position = Vector2(randi()%320,randi()%240)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
