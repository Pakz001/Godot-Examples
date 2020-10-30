extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# In the project settings we need to add the 'Mouse_left" text to the inputsettings
	# and set it to recieve the left mouse button.
	
	# When the left mouse is clicked :
	if Input.is_action_just_pressed("Mouse_left"):
		# Print the mouse position. (position is a Vector2)
		# you can also read the X value by adding the .x to that function
		print("Left mouse pressed at position : "+str(get_global_mouse_position()))
#	pass
