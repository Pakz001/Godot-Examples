extends TextureButton

# The name of the voxel we want to be the voxel the player places when
# the button is pressed.
export (String) var voxel_name;

# A exported boolean for deciding whether this button is selected when
# the game starts.
export (bool) var start_selected = false;


func _ready():
	# Connect the "pressed" signal to the "on_press" function so we can change the
	# voxel when the button is pressed.
	connect("pressed", self, "on_press");

	# If this button needs to be selected when the game starts...
	if (start_selected == true):
		# Tell Voxel_Inventory.gd that this button is/was selected.
		get_parent().last_pressed_button = self;
		# Call the select function so the button can do whatever it needs to do
		# when it is selected.
		select();
	# If this button is not selected when the game starts...
	else:
		# Call the deselect function so the button can do whatever it needs to do
		# when it is deselected.
		deselect();


func on_press():
	# Tell Voxel_Inventory.gd to change the selected voxel.
	get_parent().change_player_voxel(voxel_name, self);


func select():
	# Make the select texture visible since the button is selected.
	get_node("Select_Texture").visible = true;


func deselect():
	# Make the select texture invisible since the button is no longer selected.
	get_node("Select_Texture").visible = false;


