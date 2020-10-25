extends Node2D

var pic = Image.new()
var pictex = ImageTexture.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pic.load("res://insects.png")	
	pictex.create_from_image(pic)
	#pass # Replace with function body.

func _draw():
	draw_rect ( Rect2(Vector2(0,0),Vector2(648,480)), Color(0,0,0,1), true, 1.0, false )
	draw_texture_rect_region(pictex,Rect2(Vector2(100,100),Vector2(64,64)),Rect2(Vector2(0,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(200,100),Vector2(64,64)),Rect2(Vector2(16,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(300,100),Vector2(64,64)),Rect2(Vector2(32,0),Vector2(16,16)))
	draw_texture_rect_region(pictex,Rect2(Vector2(400,100),Vector2(64,64)),Rect2(Vector2(48,0),Vector2(16,16)))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
