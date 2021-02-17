#
# A test to see if I can create interesting insides of a asteroid
# of my dudespacemining game.
#
#
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
			if(x>0 && x<mapwidth && y>0 && y<mapheight):			
				if(add<8 && i==int(l-2)):				
					proj.push_front(Vector2(x,y))
					projangle.push_front(rand_range(-TAU,TAU))
					projlen	.push_front(rand_range(2,mapwidth))
				if(rand_range(0,10)<1):
					brushsize=rand_range(1,3)
				for y1 in range(-brushsize,brushsize):
					for x1 in range(-brushsize,brushsize):
						if(x+x1<0 || x+x1>=mapwidth || y+y1<0 || y+y1>=mapheight):continue
						map[int(x+x1)][int(y+y1)]=1
			else:
				break
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
			if(map[x][y]==1):
				draw_rect(Rect2(Vector2(x*2,y*2),Vector2(2,2)),Color(1,1,1,1))
	
	pass
