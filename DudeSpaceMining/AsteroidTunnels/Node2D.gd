#
# A test to see if I can create interesting insides of a asteroid
# of my dudespacemining game.
#
# TODO : Convex hull??, make tunnels accessable
#


extends Node2D

var time=0
# map is the map we end up with , that with the maze like thing
var mapwidth = 256
var mapheight = 256
var map = []

var proj = []
var projangle = []
var projlen = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# first we create our map array[][]
	for x in range(0,mapwidth):
		map.append([])
		map[x] = []
		for y in range(0,mapheight):
			map[x].append([])
			map[x][y] = 0
	splode()
	pass # Replace with function body.

func splode():
	
	for y in range(mapheight):
		for x in range(mapwidth):
			map[x][y]=0
			
	for i in range(6):
		proj.append(Vector2(mapwidth/2,mapheight/2))
		projangle.append(rand_range(0,PI*2.0))
		projlen.append(mapwidth)
	var brushsize=1
	while(!proj.empty()):
		var x = proj[0].x
		var y = proj[0].y
		var l = projlen[0]
		var a = projangle[0]
		proj.pop_front()
		projlen.pop_front()
		projangle.pop_front()
		var add = rand_range(0,10)	
		for i in range(l):
			x+=cos(a)*1
			y+=sin(a)*1
			if(rand_range(0,10)<2):
				a+=rand_range(-PI/2,PI/2)
			if(x>16 && x<mapwidth-16 && y>16 && y<mapheight-16):			
				if(add<8 && i==int(l-2)):				
					proj.push_front(Vector2(x,y))
					projangle.push_front(rand_range(-TAU,TAU))
					projlen	.push_front(rand_range(2,mapwidth))
				if(rand_range(0,10)<1):
					brushsize=rand_range(1,3)
				for y1 in range(-brushsize,brushsize):
					for x1 in range(-brushsize,brushsize):
						if(x+x1<16 || x+x1>=mapwidth-16 || y+y1<16 || y+y1>=mapheight-16):continue
						map[int(x+x1)][int(y+y1)]=1
			else:
				break
	floodfill(1,1,10)
	#
	# Here we grow the edges randomly
	for i in range(mapwidth*mapwidth*1):
		var x1 = int(rand_range(1,mapwidth-1))
		var y1 = int(rand_range(1,mapheight-1))
		if(map[x1][y1]==10):
			
			if(map[x1-1][y1]==1 || map[x1+1][y1]==1 || map[x1][y1-1]==1 || map[x1+1][y1+1]==1 || map[x1-1][y1]==20 || map[x1+1][y1]==20 || map[x1][y1-1]==20 || map[x1+1][y1+1]==20):				
				map[x1][y1]=20
	# Here we loop through the map and fill in edges
	
	var start = false
	for x1 in range(5,mapwidth-5):
		var list = []
		start=false
		for y1 in range(5,mapheight-5):
			if(map[x1][y1]==20 && map[x1][y1+1]==10 && start==false):
				start=true
			if(start==true && map[x1][y1]==10):
				list.append(Vector2(x1,y1))
			if(map[x1][y1+1]==20 && start==true):
				for i in range(list.size()):
					map[list[i].x][list[i].y]=20				
				start=false
	start = false
	for y1 in range(5,mapheight-5):
		var list = []
		start=false
		for x1 in range(5,mapwidth-5):
			if(map[x1][y1]==20 && map[x1+1][y1]==10 && start==false):
				start=true
			if(start==true && map[x1][y1]==10):
				list.append(Vector2(x1,y1))
			if(map[x1+1][y1]==20 && start==true):
				for i in range(list.size()):
					map[list[i].x][list[i].y]=20				
				start=false
	# Here we grow the edges randomly
	for i in range(mapwidth*mapwidth*3):
		var x1 = int(rand_range(1,mapwidth-1))
		var y1 = int(rand_range(1,mapheight-1))
		if(map[x1][y1]==10):
			
			if(map[x1-1][y1]==1 || map[x1+1][y1]==1 || map[x1][y1-1]==1 || map[x1+1][y1+1]==1 || map[x1-1][y1]==20 || map[x1+1][y1]==20 || map[x1][y1-1]==20 || map[x1+1][y1+1]==20):				
				map[x1][y1]=20

	pass


func _process(delta):
	time+=1
	if time>100:
		time=0
		splode()
		
	# Note this update()
	# It makes sure the _draw function gets updated every frame
	#
	update()
	pass	

func _draw():
	#Here we draw the map
	for y in range(0,mapheight):
		for x in range(0,mapwidth):
			if(map[x][y]==20 || map[x][y]==0):
				draw_rect(Rect2(Vector2(x*2,y*2),Vector2(2,2)),Color(.7,.5,0,1))
			if(map[x][y]==1):
				draw_rect(Rect2(Vector2(x*2,y*2),Vector2(2,2)),Color(.2,.05,0,1))
			if(map[x][y]==10):
				draw_rect(Rect2(Vector2(x*2,y*2),Vector2(2,2)),Color(0,0,0,1))
	
	pass

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
		var x1 = list[0].x
		var y1 = list[0].y
		# flood the map on x1 and y1
		map[x1][y1]=val
		# remove the current cell from the list
		list.pop_front()
		# Here we check above/left/right/down our current x1 y1
		# position if we can flood there and if so add this to the list.
		# We make sure first to not check outside our map[][] area
		if(y1-1>=0 && map[x1][y1-1]==floodme):
			list.push_front(Vector2(x1,y1-1))
		if(y1+1<mapheight && map[x1][y1+1]==floodme):
			list.push_front(Vector2(x1,y1+1))
		if(x1-1>=0 && map[x1-1][y1]==floodme):
			list.push_front(Vector2(x1-1,y1))
		if(x1+1<mapwidth && map[x1+1][y1]==floodme):
			list.push_front(Vector2(x1+1,y1))

	pass
