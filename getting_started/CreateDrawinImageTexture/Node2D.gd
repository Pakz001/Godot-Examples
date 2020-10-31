extends Node2D

var _image = Image.new()
var _imageTexture = ImageTexture.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	_image.create(int(64), int(64), false, Image.FORMAT_RGBA8)
	_image.lock()
	for y in range(64):
		for x in range(64):
			var actualX := int(x)
			var actualY := int(y)
			_image.set_pixel(x, y,Color(randf(),randf(),randf()))
	_image.unlock()
	_image.expand_x2_hq2x()
	_image.expand_x2_hq2x()
	_imageTexture.create_from_image(_image)
	#pass # Replace with function body.

func _draw():
	draw_texture(_imageTexture,Vector2(50,50))	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
