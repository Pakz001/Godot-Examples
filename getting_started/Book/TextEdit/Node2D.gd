extends Node2D

onready var text_edit
onready var n = 0
onready var buttons = [0,Button,Button,Button]

# Called when the node enters the scene tree for the first time.
func _ready():
	text_edit = TextEdit.new()
	text_edit.rect_position = Vector2(21,21) #The location top left
	text_edit.rect_size = Vector2(210,190) #Width and height
	text_edit.text = "Empty" #Our starting text
	.add_child(text_edit)
	create_button("Save",21)
	create_button("Open",81)
	
	#pass # Replace with function body.

func create_button(btn_name,pos):
	n += 1
	var button = Button.new()
	button.rect_size = Vector2(21,27)
	button.rect_position = Vector2(pos,210)
	button.connect("button_down",self,btn_name+"_press") #create links to our functions
	button.text = btn_name
	buttons[n] = button
	.add_child(buttons[n])

func Save_press():
	var file = File.new()
	var current_path = "res://text_file.txt"
	file.open(current_path,File.WRITE)
	file.store_string(text_edit.text)
	file.close()

func Open_press():
	var file = File.new()
	var current_path = "res://text_file.txt"
	file.open(current_path,File.READ)
	text_edit.text = file.get_as_text()
	file.close()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
