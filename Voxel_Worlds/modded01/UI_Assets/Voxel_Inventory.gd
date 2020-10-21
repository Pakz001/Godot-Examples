extends HBoxContainer

# A NodePath to the player camera. This is so we can change the voxel it will place.
export (NodePath) var path_to_player;
# A variable to hold a reference to the player camera.
var player;

# A variable to store the last Voxel_Inventory_Button pressed, so we can deselect it when
# a new Voxel_Inventory_Button is pressed.
var last_pressed_button = null;


func _ready():
	# If there is no player camera in the NodePath, then just return.
	if (path_to_player == null):
		return;
	
	# Otherwise, get the player camera from path_to_player and assign it to the player variable.
	player = get_node(path_to_player);


func change_player_voxel(new_voxel_name, button):
	# If there is no player camera in the NodePath, then just return.
	if (path_to_player == null):
		return
	
	# Set the player's current_voxel variable to the passed in voxel name (new_voxel_name)
	player.current_voxel = new_voxel_name;
	
	# If last_pressed_button is NOT null, then deselect the last pressed button.
	if (last_pressed_button != null):
		last_pressed_button.deselect();
	
	# Assign last_pressed_button to the passed in button, and call its select function.
	last_pressed_button = button;
	last_pressed_button.select();

