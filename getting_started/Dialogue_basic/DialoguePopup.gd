extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dialogue setget dialogue_set
var npc


func dialogue_set(new_value):
	dialogue = new_value
	$ColorRect/dialogue.text = new_value

func open():
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 30.0 / dialogue.length() #30 is a quater of 120hrz screen update here
	$AnimationPlayer.play("ShowDialogue")

func close():
	get_tree().paused = false
	hide()

func _ready():
	set_process_input(false)
	

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
