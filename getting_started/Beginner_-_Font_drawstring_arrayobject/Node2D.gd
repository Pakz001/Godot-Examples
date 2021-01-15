#

extends Node2D


# An inner class in this class file.
class point extends Node2D:
	var x
	var y


var mypoints = []

var map = []
var font # our font we use for draw_string

func _ready():
	#
	# We rip the font here from a label.
	#
	var label = Label.new()	
	font = label.get_font("")
	label.queue_free()
	
	for i in range(5):
		var a = point.new()
		mypoints.append(a)
		mypoints[i].x = i
	
	#
	pass # Replace with function body.


func _draw():
	#
	for i in range(5):
		draw_string(font,Vector2(100,100+i*15),str(mypoints[i].x),Color(1,1,1,1))
	
	pass
	
#
