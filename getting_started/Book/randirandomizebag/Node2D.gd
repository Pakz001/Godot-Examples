extends Node2D

#
# A random bag is a list of values that the game can use to get a less
# random ouput. Say our sword has a power and upkeep that at least let
# it hit two hits with the damage of 5 every 5 strikes.
# 
#


# Called when the node enters the scene tree for the first time.
func _ready():	
	# Set up a random bag array.
	var bag = []
	# Randomize the output of the randi function
	randomize()
	# create 3 random integers from 0 to 9
	bag.append(randi()%10)
	bag.append(randi()%10)
	bag.append(randi()%10)
	# In our bag when taking out a value we want at least the int value
	# of 5 two times.
	bag.append(5)
	bag.append(5)
	#
	for i in range(5):
		print("Random bag values : "+str(bag[i]))
	
	# This is how you can select a value from the random bags array.
	randomize()
	print("Our player hits the enemy and dealt a damge of : "+str(bag[randi()%5]))
	
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
