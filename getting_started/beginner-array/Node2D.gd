#
# Example of how to create a multidimensional array with a function
# and how to pass a array to a function.
#

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	array_2d(map,10,10)
	map[9][9] = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#
# Create a array with a function
# 
func array_2d(a,rows,columns):
	for r in range(rows):
		a.append([])            # add a row
		a[r].resize(columns)    # add columns
  
