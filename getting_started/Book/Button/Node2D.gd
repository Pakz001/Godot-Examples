extends Node2D

# Create our global button
var mybutton = Button.new()	

# Called when the node enters the scene tree for the first time.
func _ready():
	# set the button text
	mybutton.text = "Press me"
	# put the button somewhere on the screen 100x100
	.translate(Vector2(100,100))
	# add the button to the scene
	.add_child(mybutton)
	# create a connect so we can do something when the user pressed the button
	mybutton.connect("pressed",self,"mybutton_pressed")
	#pass # Replace with function body.

# Here we do stuff when the button was pressed
func mybutton_pressed():
	mybutton.text = "I has been pressed"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
