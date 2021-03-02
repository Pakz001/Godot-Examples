extends KinematicBody2D

var collidedObject:KinematicCollision2D
var collided=false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bulletdirection
var bullettimeout = 100

var tilemap
var cell
var tile_id
#onready var target_node = get_node("/root/Main/Level/TileMap")

func _physics_process(delta):
	bullettimeout-=1
	if(bullettimeout<0):
		queue_free()
	var collidedObject = move_and_collide(bulletdirection)
	

	if(collidedObject):
		var pos = collidedObject.position
		
		var ex=false
		var angle=0
		var dis=0
		var cell
		while(ex==false):
			pos = collidedObject.position/tilemap.scale #note the scale division!!
			#pos = to_local(pos)
			#pos.y-=16*4
			#pos.x+=16*4
			dis+=.01
			angle+=.1
			pos.x+=cos(angle)*dis	
			pos.y+=sin(angle)*dis
			cell = tilemap.world_to_map(pos-collidedObject.normal)
			#cell = tilemap.world_to_map(pos)
			
			#cell.y-=8
			#cell.x+=3
			cell.y-=2
			cell.x+=1
			#print(str(tilemap.get_cell_autotile_coord(cell.x,cell.y)))
			if( destroyable(tilemap.get_cell_autotile_coord(cell.x,cell.y) ) ):
				#tilemap.set_cellv(cell,-1)
				#for z in range(-53,10):
				#for zz in range(-28,10):
				tilemap.set_cell(cell.x,cell.y,0,false,false,false,Vector2(1,1))
				#print(str(cell.x)+","+str(cell.y))	
				#print(str(tilemap.get_cell_autotile_coord(cell.x,cell.y)))
				ex=true
		
		queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	#tilemap = get_parent().get_node("/root/Main/Level/TileMap")
	tilemap = get_node("/root/Main/Level/TileMap")
	pass # Replace with function body.

func destroyable(val):
	if(val.x==3 && val.y==0):
		return true
	if(val.x==4 && val.y==0):
		return true
	if(val.x==5 && val.y==0):
		return true
	if(val.x==3 && val.y==1):
		return true
	if(val.x==4 && val.y==1):
		return true
	if(val.x==5 && val.y==1):
		return true
	if(val.x==3 && val.y==2):
		return true
	if(val.x==4 && val.y==2):
		return true
	if(val.x==5 && val.y==2):
		return true
	if(val.x==9 && val.y==1):
		return true
	if(val.x==10 && val.y==0):
		return true
	if(val.x==10 && val.y==2):
		return true
	if(val.x==11 && val.y==1):
		return true
	if(val.x==10 && val.y==5):
		return true
	if(val.x==11 && val.y==5):
		return true
	if(val.x==12 && val.y==5):
		return true
	if(val.x==13 && val.y==5):
		return true
	if(val.x==14 && val.y==5):
		return true
	if(val.x==13 && val.y==3):
		return true
	if(val.x==13 && val.y==4):
		return true
	if(val.x==13 && val.y==5):
		return true
	if(val.x==13 && val.y==6):
		return true
	if(val.x==13 && val.y==7):
		return true	
	if(val.x==7 && val.y==7):
		return true
	if(val.x==8 && val.y==7):
		return true
	if(val.x==9 && val.y==7):
		return true
	if(val.x==8 && val.y==3):
		return true

	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
