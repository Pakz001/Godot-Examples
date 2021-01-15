#

extends Node2D


func _ready():
	pass # Replace with function body.


func _draw():
	# draw rectangle white not transparent
	# Note that you need a rect2 for the location and width and height.
	draw_rect(Rect2(Vector2(0,0),Vector2(50,50)),Color(1,1,1,1))
	# draw a rectangle white not transparent and only the outlines(false)
	draw_rect(Rect2(Vector2(50,0),Vector2(50,50)),Color(1,1,1,1),false)
	# draw a rectangle white not transparent and outlines with width of 5
	draw_rect(Rect2(Vector2(100,0),Vector2(50,50)),Color(1,1,1,1),false,5)
	# draw a rectangle white not transparent(.,.,.,1=not trans) width outlines of 5 and antialiased
	draw_rect(Rect2(Vector2(150,0),Vector2(50,50)),Color(1,1,1,1),false,5,true)
	
	pass
	
#
