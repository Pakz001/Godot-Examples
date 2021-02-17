extends Node2D

var mapwidth = 100
var mapheight = 100
var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# first we create our map array[][]
	for x in range(0,mapwidth):
		map.append([])
		map[x] = []
		for y in range(0,mapheight):
			map[x].append([])
			map[x][y] = 0
	for i in range(mapwidth):
		map[i][15]=10

	floodfill(10,10,1)
	pass # Replace with function body.

func floodfill(x,y,val):
	# this is the value which we going to flood over
	var floodme = map[x][y]
	# this is our flood list. It contains and will contain each floodable
	# cell
	var list = []
	# put the start cell on the list
	list.append(Vector2(x,y))
	# while there is something on the list
	while(!list.empty()):
		# get our current cell inside these variables x1 and y1
		var x1 = list[list.size()-1].x
		var y1 = list[list.size()-1].y
		# flood the map on x1 and y1
		map[x1][y1]=val
		# remove the current cell from the list
		list.pop_back()
		# Here we check above/left/right/down our current x1 y1
		# position if we can flood there and if so add this to the list.
		# We make sure first to not check outside our map[][] area
		if(y1-1>=0 && map[x1][y1-1]==floodme):
			list.append(Vector2(x1,y1-1))
		if(y1+1<mapheight && map[x1][y1+1]==floodme):
			list.append(Vector2(x1,y1+1))
		if(x1-1>=0 && map[x1-1][y1]==floodme):
			list.append(Vector2(x1-1,y1))
		if(x1+1<mapwidth && map[x1+1][y1]==floodme):
			list.append(Vector2(x1+1,y1))

	pass

func _draw():
	#Here we draw the map
	for y in range(0,mapheight):
		for x in range(0,mapwidth):
			if(map[x][y]==1):
				draw_rect(Rect2(Vector2(x*2,y*2),Vector2(2,2)),Color(1,1,1,1))
	
	pass
