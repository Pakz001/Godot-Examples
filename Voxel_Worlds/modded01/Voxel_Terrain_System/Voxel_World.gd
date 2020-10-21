extends Spatial

# A dictionary that holds all possible voxels.
#
# The dictionary is structured as follows:
#	Name of voxel (example, "Stone"):
#		The name of the voxel. This name will be used to get the voxel's data as needed.
#		{
#			transparent:
#				A boolean for whether this voxel is transparent or not.
#			solid:
#				A boolean for whether this voxel is solid or not.
#			texture:
#				The coordinates of the tile that will be the texture for this voxel.
#			texture_NORTH, texture_SOUTH, texture_EAST, texture_WEST, texture_TOP, texture_BOTTOM:
#				If added, these coordinates will override the texture facing that direction.
#		}


var voxel_dictionary = {
	"Stone":
		{"transparent":false, "solid":true,
		"texture":Vector2(0, 0)},
	"Bedrock":
		{"transparent":false, "solid":true,
		"texture":Vector2(2, 0)},
	"Cobble":
		{"transparent":false, "solid":true,
		"texture":Vector2(1, 0)},
	"Dirt":
		{"transparent":false, "solid":true,
		"texture":Vector2(0, 1)},
	"Grass":
		{"transparent":false, "solid":true,
		"texture":Vector2(0, 1), "texture_TOP":Vector2(2, 1),
		"texture_NORTH":Vector2(1, 1), "texture_SOUTH":Vector2(1, 1), "texture_EAST":Vector2(1, 1), "texture_WEST":Vector2(1, 1)},
}

# A list that we will use to store the voxels. We'll use this so we can store the
# voxel data in the chunk as a bunch of integers instead of dictionary data.
# This makes it easier to save/load chunk data, and makes the file data much smaller.
# (NOTE: We are not adding saving/loading in this tutorial)
var voxel_list = [];

# The size of the texture that contains the voxel textures. It is assumed that this texture
# will always be a square texture.
# (For example, a value of 96 means it will assume the texture size is 96x96)
export (int) var voxel_texture_size = 96;
# The size of each texture tile/face in the voxel texture. As with voxel_texture_size, it is assumed
# that each voxel texture tile/face will be a square.
export (int) var voxel_texture_tile_size = 32;

# Because UV maps are positioned in a range from 0-1, we need to figure out how much space
# each tile/face in the voxel texture takes. We will store the results in voxel_texture_unit.
var voxel_texture_unit;

# A reference to the chunk scene so we can instance chunks as needed.
var chunk_scene = preload("res://Voxel_Terrain_System/Voxel_Chunk.tscn");

# The node that will hold all of the chunks. This is just for better organization in the remote debugger.
var chunk_holder_node;

# The size of each voxel. A bigger value will lead to bigger voxels, while a small value will lead
# to smaller voxels. This value has to be a integer!
var VOXEL_UNIT_SIZE = 1;


func _ready():
	# Get the Chunks node and assign it to chunk_holder_node.
	chunk_holder_node = get_node("Chunks");
	
	# Calculate how much space each voxel texture tile/face takes in UV space.
	# To do this, we first figure out how many tiles there are in the texture (voxel_texture_size / voxel_texture_tile_size)
	# Then we divide 1.0 by the amount of tiles/faces in the texture, and that
	# will give us the amount of space each tile/face takes in UV space.
	voxel_texture_unit = 1.0 / (voxel_texture_size / voxel_texture_tile_size);
	
	# Fill the voxel list...
	for voxel_name in voxel_dictionary.keys():
		voxel_list.append(voxel_name);
	
	# Make a 4x1x4 (X - Y - Z) world with chunks containing a maximum of 16x16x16 voxels.
	make_voxel_world(Vector3(4, 4, 4), Vector3(16, 16, 16));


func make_voxel_world(world_size, chunk_size):
	# Remove old chunks from chunk_holder_node
	for child in chunk_holder_node.get_children():
		child.queue_free();
	
	# Make new chunks. Start by making a three dimensional for loop.
	for x in range(0, world_size.x):
		for y in range(0, world_size.y):
			for z in range(0, world_size.z):
				
				# Make a new chunk and add it to chunk_holder_node.
				var new_chunk = chunk_scene.instance();
				chunk_holder_node.add_child(new_chunk);
				
				# Set its position according to its position in for loop multiplied by
				# the size of the voxels multiplied by the amount of voxels in a chunk.
				new_chunk.global_transform.origin = Vector3(x * (chunk_size.x * VOXEL_UNIT_SIZE),
															y * (chunk_size.y * VOXEL_UNIT_SIZE),
															z * (chunk_size.z * VOXEL_UNIT_SIZE));
				
				# Give the newly created chunk a reference to this, Voxel_World.gd.
				new_chunk.voxel_world = self;
				
				# Tell the chunk to set itself up by calling the setup function.
				# Pass in the size the chunk is expected to be, along with the size of the voxels.
				new_chunk.setup(chunk_size.x, chunk_size.y, chunk_size.z, VOXEL_UNIT_SIZE);
	
	print ("Done making voxel world!");


# This is just a helper function to get the voxel data stored in voxel_dictionary from a string.
func get_voxel_data_from_string(voxel_name):
	if (voxel_dictionary.has(voxel_name) == true):
		return voxel_dictionary[voxel_name];
	return null;

# This is a helper function to get voxel data using a integer. It gets the data using
# voxel_list to get the key, the voxel name, so it can get the data from voxel_dictionary.
func get_voxel_data_from_int(voxel_integer):
	return get_voxel_data_from_string(voxel_list[voxel_integer]);

# This is a helper function to get the voxel integer (ID) using a the voxel's name (a string).
func get_voxel_int_from_string(voxel_name):
	return voxel_list.find(voxel_name);


func set_world_voxel(position, voxel):
	# Make a variable to determine whether we were succesfull in placing a voxel.
	var result = false;
	#print(position.y);
	# Go through each chunk in chunk_holder_node...
	for chunk in chunk_holder_node.get_children():
		# See if we can place the passed in voxel (voxel) at the passed in position (position)
		# within this chunk. The result variable will be true if the voxel was placed, false if it was not.
		result = chunk.set_voxel_at_position(position, voxel);		
		
		# If the voxel was successfully placed, then break the for loop.
		if (result == true):
			break;
	
	# If you want, you can check to see if a voxel was placed or not using the code bellow:
	#
	#if (result == true):
	#	print ("Voxel successfully placed");
	#else:
	#	print ("Could not place voxel!");
	



