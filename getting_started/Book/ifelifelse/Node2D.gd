extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var aa = "hello"
	var bb = "helloz"
	var a=10
	var b=20
	if a<b:
		print("phase 1")
	elif b>a:
		print("phase 2")
	else:
		print("phase 3")
		
	# if a has the same value as b or if a is smaller then b	
	if a==b || a<b:
		print("remember the Alamo")
	else:
		print("rememberz")
	# compare a string
	if aa==bb:
		print("string comparez")
	# compare a string with the bb string minus its last character	
	if aa==bb.left(bb.length()-1):
		print("string compares...")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
