extends Node2D

# this is our global map
var map = []

# Called when the node enters the scene tree for the first time.
func _ready():	
	# create our multi dimensional array 10x10
	for x in range(0,10):
		map.append([])
		map[x] = []
		for y in range(0,10):
			map[x].append([])
			map[x][y] = 0
			
	# Fill our map array with values		
	# Loop through the map	
	for x in range(0,10):
		for y in range(0,10):
			map[x][y]=randi()%2 # put numbers from 0 to up and including 1
	#pass # Replace with function body.


func _draw():
	# Here we draw our tilemap using the draw_rect function
	# Color uses floats
	for x in range(0,10):
		for y in range(0,10):
			if map[x][y]==1:
				draw_rect(Rect2(Vector2(x*64,y*64),Vector2(64,64)),Color(1,.2,.2),true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
