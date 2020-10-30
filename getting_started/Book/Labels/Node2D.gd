extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a label
	var mylabel = Label.new()	
	# Set the text for the label mylabel
	mylabel.text = "mylabel contents - Hello"	
	# put this label to the 100x100 location of the screen
	.translate(Vector2(100,100))
	# add the label to the scene(I think(
	.add_child(mylabel)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
