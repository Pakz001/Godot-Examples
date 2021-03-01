extends Camera2D

export var target = "../Player"
onready var target_node = get_node(target)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta):
	position = target_node.position
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
