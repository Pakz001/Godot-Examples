extends Node2D

var DialoguePopup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	

	#DialoguePopup = get_tree().root.get_node("Root/CanvasLayer/DialoguePopup")
	DialoguePopup = get_node("CanvasLayer/DialoguePopup")
	DialoguePopup.show()
	DialoguePopup.dialogue = "Hello, I lost my favourite shoes. Can you find them for me? I wil give you 6 fishes and some worms and a fishing pole if you can find them."
	DialoguePopup.open()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#DialoguePopup.show()

#	pass
