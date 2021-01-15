#

extends Node2D

var font # our font we use for draw_string
var yello=0
var cnt=0

func _ready():
	# 
	# Initialise a label to get its font.
	var label = Label.new()	
	font = label.get_font("")
	label.queue_free()	
	pass # Replace with function body.

func _process(delta):
	cnt+=1
	if cnt>100:
		cnt=0
		yello=0
	#
	# If pressed the f key
	# KEY_ << for more keycodes
	#
	if (Input.is_key_pressed(KEY_F)):
		print("yello")
		yello=1
	#
	# Note this update()
	# It makes sure the _draw function gets updated every frame
	#
	update()
	pass
	
func _draw():	
	draw_string(font,Vector2(100,10),"Press the F key to draw rect.",Color(1,1,1,1))	
	# draw our rect
	if yello==1:
		draw_rect(Rect2(Vector2(0,0),Vector2(50,50)),Color(1,1,1,1))		
	pass
	
#
