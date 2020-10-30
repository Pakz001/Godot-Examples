extends Node2D


var cont = Control.new()
var g = 0
var buttons = [0,Button,Button,Button]
const x = 30 # x position of the buttons
var mylabel = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# create our buttons
	create_button() # our custom function
	buttons[1].text = "Start"
	create_button()
	buttons[2].text = "Settings"
	create_button()
	buttons[3].text = "Quit"
	.add_child(cont)	# add the control to the scene
	# Add a label
	mylabel.text = "Nothing.."
	mylabel.rect_position = Vector2(0,200)
	# add the connects
	buttons[1].connect("pressed",self,"but1")	
	buttons[2].connect("pressed",self,"but2")
	buttons[3].connect("pressed",self,"but3")
	# add the label to the scene
	.add_child(mylabel)

	#pass # Replace with function body.

# The functions for handling the buttons
func but1():
	mylabel.text = "Start pressed" # modify the label text
func but2():
	mylabel.text = "Settings pressed"
func but3():
	mylabel.text = "Quit pressed"

# This function creates the buttons
func create_button():
	g += 1
	var button = Button.new()
	button.rect_size = Vector2(90,40)
	button.rect_position = Vector2(x,g*45)
	button.set_text_align(HALIGN_CENTER)
	buttons[g] = button
	cont.add_child(buttons[g])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
