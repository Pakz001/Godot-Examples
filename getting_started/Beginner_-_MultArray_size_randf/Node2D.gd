#

extends Node2D

var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	array_2d(map,10,5)
	#
	# array.size() returns the size of the array
	# array[0].size() return the size of the arrays second container
	#
	for y in range(map[0].size()):
		for x in range(map.size()):
			map[x][y] = randf()
	pass # Replace with function body.


func _draw():
	#
	# Here we create a new array and copy the 2 dimensional array
	# into it and thus creating a 2 dimensional array.
	#
	var map2 = map
	#
	#
	# Draw a tilemap
	for y in range(map2[0].size()):
		for x in range(map2.size()):
			var r = map2[x][y]
			draw_rect ( Rect2(Vector2(x*32,y*32),Vector2(32,32)), Color(r,0,0,1), true, 1.0, false )
	
#
# Create a array with a function
# 
func array_2d(a,rows,columns):
	for r in range(rows):
		a.append([])            # add a row
		a[r].resize(columns)    # add columns
  
