extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapwidth = 256
var mapheight = 256
var map = []

var proj = []
var projangle = []
var projlen = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#var cnt=0
	#for j in range(-100,0):
#		for i in range(-100,0):
#			var c = get_cell(i,j)
#			var d = get_cell_autotile_coord(i+100,j+100)
#			set_cell(i,j,0,false,false,false,d)
#			#set_cell(i,j,1)



	#randomize()
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
	
	#var c = get_cell(0,0)
	#var d = get_cell_autotile_coord(2,2)
	#print(d)
	for y in range(mapheight):
		for x in range(mapwidth):
			if(map[x][y]==20):
				map[x][y]=0
	# Here we copy the map into the tilemap grid
	for y in range(mapheight):
		for x in range(mapwidth):
			#set_cellv(Vector2(x,y),-1)
			if(map[x][y]==1): # the halls of asteroid
	#			var c = get_cell(0,0)
	#			var d = get_cell_autotile_coord(0,0)
	#			set_cell(i,j,0,false,false,false,d)
	#			set_cell(x,y,-1)
				#set_cell(x-256,y-256,0,false,false,false,Vector2(110,0))
				
				set_cell(x-128,y-128,0,false,false,false,Vector2(1,1))
			if(map[x][y]==0): #inside solid of asteroid
				set_cell(x-128,y-128,0,false,false,false,Vector2(4,1))
				# left edge 
				if(map[x-1][y]==1 && map[x][y-1]==1 && map[x][y+1]==1 && map[x+1][y]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(11,5))
				# right edge
				if(map[x+1][y]==1 && map[x][y-1]==1 && map[x][y+1]==1 && map[x-1][y]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(15,5))
				# top edge
				if(map[x-1][y]==1 && map[x+1][y]==1 && map[x][y+1]==0 && map[x][y-1]==1):
					set_cell(x-128,y-128,0,false,false,false,Vector2(13,3))
				# bottom edge
				if(map[x-1][y]==1 && map[x+1][y]==1 && map[x][y-1]==0 && map[x][y+1]==1):
					set_cell(x-128,y-128,0,false,false,false,Vector2(13,7))
				# middle piece of vertical line.
				if(map[x-1][y]==1 && map[x+1][y]==1 && map[x][y-1]==0 && map[x][y+1]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(13,4))
				# middle piece of horizontal line.
				if(map[x][y-1]==1 && map[x][y+1]==1 && map[x-1][y]==0 && map[x+1][y]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(12,5))
				# right part of rock finishing
				if(map[x+1][y]==1 && map[x-1][y]==0 && map[x][y-1]==0 && map[x][y+1]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(5,1))					
				# left part of rock finsihing
				if(map[x-1][y]==1 && map[x+1][y]==0 && map[x][y-1]==0 && map[x][y+1]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(3,1))					
				# top part of rock finishing
				if(map[x][y-1]==1 && map[x][y+1]==0 && map[x-1][y]==0 && map[x+1][y]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(4,0))
				 #bottom part of rock finishing
				if(map[x][y+1]==1 && map[x][y-1]==0 && map[x-1][y]==0 && map[x+1][y]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(4,2))
				 #above nothing / left empty / right solid / below solid
				if(map[x][y-1]==1 && map[x-1][y]==1 && map[x+1][y]==0 && map[x][y+1]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(3,0))
				# abocve noting/ left solid / right nothing / below solid
				if(map[x][y-1]==1 && map[x-1][y]==0 && map[x+1][y]==1 && map[x][y+1]==0):
					set_cell(x-128,y-128,0,false,false,false,Vector2(5,0))
				 #above solid / left empty / right solid / below empty
				if(map[x][y-1]==0 && map[x-1][y]==1 && map[x+1][y]==0 && map[x][y+1]==1):
					set_cell(x-128,y-128,0,false,false,false,Vector2(3,2))
				 #above solid / left solid / right empty / below empty
				if(map[x][y-1]==0 && map[x-1][y]==0 && map[x+1][y]==1 && map[x][y+1]==1):
					set_cell(x-128,y-128,0,false,false,false,Vector2(5,2))
				# above nothing / right nothing / left nothing / below nothing
				if(map[x][y-1]==1 && map[x+1][y]==1 && map[x-1][y]==1 && map[x][y+1]==1):
					set_cell(x-128,y-128,0,false,false,false,Vector2(8,3))
			if(map[x][y]==20): #rock of asteroid
				set_cell(x-128,y-128,0,false,false,false,Vector2(4,1))
					
	
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
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _get_subtile_coord(id):
#    var tiles = $TileMap.tile_set
#    var rect = tilemap.tile_set.tile_get_region(id)
#    var x = randi() % int(rect.size.x / tiles.autotile_get_size(id).x)
#    var y = randi() % int(rect.size.y / tiles.autotile_get_size(id).y)
#    return Vector2(x, y)
