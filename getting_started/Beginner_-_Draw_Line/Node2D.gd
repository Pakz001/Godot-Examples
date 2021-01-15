#

extends Node2D


func _ready():
	pass # Replace with function body.


func _draw():
	# draw a line White and not transparent
	draw_line(Vector2(0,0),Vector2(100,100),Color(1,1,1,1))
	# draw a line White and not transparent and with a line thickness of 5
	draw_line(Vector2(0,100),Vector2(100,200),Color(1,1,1,1),5)
	# draw a line White and not transparent and with a line thickness of 15 and antialiased(true)
	draw_line(Vector2(0,200),Vector2(100,300),Color(1,1,1,1),15,true)
	pass
	
#
