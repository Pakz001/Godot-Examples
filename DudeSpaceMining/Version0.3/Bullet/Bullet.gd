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
			pos = collidedObject.position
			dis+=1
			angle+=.1
			pos.x+=cos(angle)*dis	
			pos.y+=sin(angle)*dis
			cell = tilemap.world_to_map(pos-collidedObject.normal)
			cell.y-=4
			cell.x+=1
			if( destroyable(tilemap.get_cell_autotile_coord(cell.x,cell.y) ) ):
				tilemap.set_cellv(cell,-1)
				ex=true
		
		queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	#tilemap = get_parent().get_node("/root/Main/Level/TileMap")
	tilemap = get_node("/root/Main/Level/TileMap")
	pass # Replace with function body.

func destroyable(val):
	if(val.x==2 && val.y==0):
		return true
	if(val.x==3 && val.y==0):
		return true
	if(val.x==4 && val.y==0):
		return true
	if(val.x==5 && val.y==0):
		return true
	if(val.x==6 && val.y==0):
		return true
	if(val.x==7 && val.y==0):
		return true
	if(val.x==8 && val.y==0):
		return true
	if(val.x==9 && val.y==0):
		return true
	if(val.x==10 && val.y==0):
		return true
	if(val.x==11 && val.y==0):
		return true
	if(val.x==11 && val.y==0):
		return true
	if(val.x==5 && val.y==1):
		return true
	if(val.x==7 && val.y==1):
		return true
	if(val.x==8 && val.y==1):
		return true
	if(val.x==9 && val.y==1):
		return true
	if(val.x==8 && val.y==2):
		return true
	if(val.x==9 && val.y==2):
		return true

	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
