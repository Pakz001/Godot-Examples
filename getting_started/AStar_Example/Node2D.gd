#
# Not tested really that much
#

extends Node2D

# this is our global map
var map = []

var path_map = []

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
	# Loop through the map set up astar
	var astar = AStar2D.new()	
	var cnt = 0
	for x in range(0,10):
		for y in range(0,10):
			if(randi()%4==1):map[y][x]=1 # put numbers from 0 to up and including 1
			
			astar.add_point(cnt, Vector2(x, y), 1)
			if(map[y][x]==1):astar.add_point(cnt, Vector2(x, y), 99)
			cnt+=1
	cnt = 0
	for x in range(0,10):
		for y in range(0,10):			
			# connect up down left and right
			if(cnt-1>-1):astar.connect_points(cnt,cnt-1,true)
			if(cnt<10*10):astar.connect_points(cnt,cnt+1,true)
			if(cnt>-1):astar.connect_points(cnt,cnt-10,true)
			if(cnt<10*10):astar.connect_points(cnt,cnt+10,true)
			cnt+=1


	path_map = astar.get_point_path(5, 8*10+8)

	#pass # Replace with function body.


func _draw():
	# Here we draw our tilemap using the draw_rect function
	# Color uses floats
	for x in range(0,10):
		for y in range(0,10):
			if map[x][y]==1:
				draw_rect(Rect2(Vector2(x*32,y*32),Vector2(32,32)),Color(1,.2,.2),true)
	for point in path_map:
		draw_rect( Rect2(Vector2(point.y*32, point.x*32) , Vector2(32,32)),Color(0,1,1,.5),true)
		
