extends Node2D


# Here we create a regular array.
var myarray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Here we append a Vector2 to the array
	myarray.append(Vector2(10,20))
	# Here we print out the x and y of the first(0) vector in the array.
	print(myarray[0].x)
	print(myarray[0].y)
	pass # Replace with function body.


