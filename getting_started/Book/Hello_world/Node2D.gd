extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var a = 2
onready var global_b=10 	#onready means this is a variable that 
							#can be read/written from everywhere in your game
onready var global_c=20
onready var global_d=30

# Called when the node enters the scene tree for the first time.
func _ready():
	var local_var = "hello"
	print("Print a variable 'a' : " + str(a))
	print("Print variables global_b,global_c,global_d added up : "+str(global_b+global_c+global_d))
	print ("Local variable local_var : "+str(local_var))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
