extends Node2D

# Here we create images and imagetextures.
var pic = Image.new()
var pictex = ImageTexture.new()

var pic2 = Image.new()
var pictex2 = ImageTexture.new()


# This is for our font.
var default_font
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pic.load("res://insects.png")	
	pictex.create_from_image(pic)
	pic2.load("res://insects2.png")	
	pictex2.create_from_image(pic2)
	default_font = Control.new().get_font("font")
	#pass # Replace with function body.

func _draw():
	
	# draw the scaled textures sections (insects.png)
	draw_rect ( Rect2(Vector2(0,0),Vector2(648,480)), Color(0,0,0,1), true, 1.0, false )
	draw_texture_rect_region(pictex,Rect2(Vector2(100,100),Vector2(64,64)),Rect2(Vector2(0,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(200,100),Vector2(64,64)),Rect2(Vector2(16,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(300,100),Vector2(64,64)),Rect2(Vector2(32,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(400,100),Vector2(64,64)),Rect2(Vector2(48,0),Vector2(16,16)))
	draw_string(default_font, Vector2(100,90), "Scaled sections of the spritesheet. insects.png", Color.red)
	
	# draw the non scaled texture sections (insects2.png)
	draw_texture_rect_region(pictex2,Rect2(Vector2(100,200),Vector2(64,64)),Rect2(Vector2(0,0),Vector2(64,64)))
	draw_texture_rect_region(pictex2,Rect2(Vector2(200,200),Vector2(64,64)),Rect2(Vector2(64,0),Vector2(64,64)))
	draw_texture_rect_region(pictex2,Rect2(Vector2(300,200),Vector2(64,64)),Rect2(Vector2(128,0),Vector2(64,64)))
	draw_texture_rect_region(pictex2,Rect2(Vector2(400,200),Vector2(64,64)),Rect2(Vector2(192,0),Vector2(64,64)))
	draw_string(default_font, Vector2(100,190), "Non scaled sections of the spritesheet. insects2.png", Color.red)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
