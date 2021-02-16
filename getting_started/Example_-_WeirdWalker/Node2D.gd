extends Node2D


# array hold a path of the walker
var array = []
# map is the map we end up with , that with the maze like thing
var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# first we create our map array[][]
	for x in range(0,20):
		map.append([])
		map[x] = []
		for y in range(0,20):
			map[x].append([])
			map[x][y] = 0
	# Our x and y variables hold the position of our walker			
	var x = 0
	var y = 0
	# map value of one is a wall or walkable area
	map[x][y]=1
	# when we get a high countout we then backtrack our path
	var countout = 0
	# We want to loop enough to fill the map(20*20 cells)
	for i in range(0,20*20*10):
		# oldx/y holds our position we can use to reset to if we fail our current step
		var oldx = x
		var oldy = y
		# stepx/y checks one step ahead
		var stepx = x
		var stepy = y
		# direction 1 is horizontal and 2 is vertical
		var dir=10
		# val holds our direction -1 or 1
		var val
		if(rand_range(0,10)<5):
			val=-1
		else:
			val=1
		# Chose if we want to move horizontal or vertical	
		if(rand_range(0,10)<5):			
			dir=1
			x+=val
			stepx +=(val*2)
		else:			
			dir=2
			y+=val
			stepy += (val*2)
		# variable go is used to cancel or go ahead with our path
		var go = true
		
		# if we step outside of the map then restore position and cancel the current step
		if(x<0 || y<0 || x>=20 || y>=20):
			x = oldx
			y = oldy
			go=false			
		# if our check ahead is outside the map then we do not check that
		if(stepx<0 || stepy<0 || stepx>=20 || stepy>=20):					
			stepx = x
			stepy = y
		# if our step ahead inside the map is already taken than fail!
		if(map[stepx][stepy]==1):
			go=false
		# if our direction is horizontal check above and below/left and right if nothing is there yet(fail!)		
		if(dir==1):
			if(y-1>=0 && map[x][y-1]==1):
				go=false
			if(y+1<20 && map[x][y+1]==1):
				go=false				
		if(dir==2):
			if(x-1>=0 && map[x-1][y]==1):
				go=false
			if(x+1<20 && map[x+1][y]==1):
				go=false				
		# if nothing is wrong then push the current position to the array
		# and put it on the map. Reset the countout since we succeeded.
		# if we failed then restore our old position and increase our 
		# backtrack trigger counter
		if go==true:
			array.push_front(Vector2(x,y))
			map[x][y]=1
			countout=0
		else:
			x = oldx
			y = oldy
			countout+=1
		# if our backtracking counter is above 5 then reset this counter
		# and backtrack on our path and put the previous position in the
		# x and y variables for the next round.
		if(countout>5):
			countout=0
			if(array.size()>1):
				array.pop_front()
				x = array[0].x
				y = array[0].y
	pass # Replace with function body.


func _draw():
	#Here we draw the map
	for y in range(0,20):
		for x in range(0,20):
			if(map[x][y]==1):
				draw_rect(Rect2(Vector2(x*16,y*16),Vector2(16,16)),Color(1,1,1,1))
	
	pass
