extends Spatial

# A variable to hold a reference to the voxel world this chunk is a part of.
var voxel_world;

# A variable to hold all of the voxels in this chunk.
# This will be a three dimensional list of integers, where each integer is
# the ID for a voxel.
var voxels;

# Three variables to hold the dimensions of the chunk.
# NOTE: This could also be stored in a Vector3!
var chunk_size_x;
var chunk_size_y;
var chunk_size_z;

# A variable to hold the size of the voxels in this chunk.
var voxel_size = 1;

# A variable to hold the Mesh that will be used to render the visible part of the chunk.
var render_mesh;
# A variable to hold all of the vertices that will be used in render_mesh.
var render_mesh_vertices;
# A variable to hold all of the normal vectors that will be used in render_mesh.
var render_mesh_normals;
# A variable to hold all of the indices that will be used in render_mesh.
var render_mesh_indices;
# A variable to hold all of the UV vectors that will be used in render_mesh.
var render_mesh_uvs;

# A variable to hold the Mesh that will be used for the collision geometry.
var collision_mesh;
# A variable to hold all of the vertices that will be used in collision_mesh.
var collision_mesh_vertices;
# A variable to hold all of the indices that will be used in collision_mesh.
var collision_mesh_indices;

# two variables: One to hold the MeshInstance node, and another to hold the CollisionShape node.
var mesh_instance;
var collision_shape;

# A variable to hold the SurfaceTool we will use to make both the mesh for the
# MeshInstance and the CollisionShape.
var surface_tool;


func _ready():
	# Get the MeshInstance and CollisionShape nodes.
	mesh_instance = get_node("MeshInstance");
	collision_shape = get_node("StaticBody/CollisionShape");
	
	# Make a new SurfaceTool and assign it to surface_tool.
	surface_tool = SurfaceTool.new();


func setup(p_chunk_size_x, p_chunk_size_y, p_chunk_size_z, p_voxel_size,mpx,mpy,mpz):
	
	# Set the class variables to the passed in arguments.
	chunk_size_x = p_chunk_size_x;
	chunk_size_y = p_chunk_size_y;
	chunk_size_z = p_chunk_size_z;
	voxel_size = p_voxel_size;
	
	# Fill the voxels variable with a bunch of null.
	# Notice how we are making row and column lists, appending to them, and then adding
	# these lists to voxels. This will make us a list of lists, effectively making a 3D list.
	voxels = [];
	for x in range(0, chunk_size_x):
		var row = [];
		for y in range(0, chunk_size_y):
			var column = [];
			for z in range(0, chunk_size_z):
				column.append(null);
			row.append(column);
		voxels.append(row);
	
	# Call the make_starter_terrain function to make flat chunk.
	make_starter_terrain(mpx,mpy,mpz);


func make_starter_terrain(mpx,mpy,mpz):
	
	#voxel_world.myworld[0][0][0] = 0
	
	# Go through each voxel in the chunk...
	for x in range(0, chunk_size_x):
		# Notice how we're only filling half of the chunk's height.
		for y in range(0, chunk_size_y):
			for z in range(0, chunk_size_z):
				
				# If the voxel at this position is at the top of the chunk, then set
				# its ID to the "Grass" voxel ID in Voxel_World.
				#if (y + 1 == chunk_size_y/2):
				#	voxels[x][y][z] = voxel_world.get_voxel_int_from_string("Grass");
				# If the voxel at this position is in the top half of the chunk, then set
				# its ID to the "Dirt" voxel ID in Voxel_World.
				#elif (y >= chunk_size_y/4):
				#	voxels[x][y][z] = voxel_world.get_voxel_int_from_string("Dirt");
				# If the voxel at this position is at the bottom of the chunk, then set
				# its ID to the "Bedrock" voxel ID in Voxel_World.
				#elif (y == 0):
				#	voxels[x][y][z] = voxel_world.get_voxel_int_from_string("Bedrock");
				# For all other voxels, set their IDs to the "Stone" voxel ID in Voxel_World.
				#else:
				#	voxels[x][y][z] = voxel_world.get_voxel_int_from_string("Stone");
	
				if (voxel_world.myworld[x+mpx ][ y+mpy][z+mpz]>0):
					voxels[x][y][z] = voxel_world.myworld[x+mpx ][ y+mpy][z+mpz]

	# Update the render mesh and the collision mesh.
	update_mesh();


func update_mesh():
	
	# Clear the old render mesh and collision mesh data.
	render_mesh_vertices = [];
	render_mesh_normals = [];
	render_mesh_indices = [];
	render_mesh_uvs = [];
	collision_mesh_vertices = [];
	collision_mesh_indices = [];
	
	# Go through the entire chunk, and fill the render mesh and collision mesh data
	# according to voxel data.
	for x in range(0, chunk_size_x):
		for y in range(0, chunk_size_y):
			for z in range(0, chunk_size_z):
				make_voxel(x, y, z);
	
	
	# Make the render mesh
	# ********************
	# Clear any old data in surface_tool, and start making a Mesh in PRIMITIVE_TRIANGLES mode.
	surface_tool.clear();
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	# Go through every vertex in render_mesh_vertices.
	for i in range(0, render_mesh_vertices.size()):
		# Add the normal vector for that vertex stored in render_mesh_normals.
		surface_tool.add_normal(render_mesh_normals[i]);
		# Add the UV map vector for that vertex stored in render_mesh_uvs.
		surface_tool.add_uv(render_mesh_uvs[i]);
		# Finally, add the vertex stored in render_mesh_vertices.
		surface_tool.add_vertex(render_mesh_vertices[i]);
	
	# Go through every index stored in render_mesh_indices.
	for i in range(0, render_mesh_indices.size()):
		# Add the index to the surface tool.
		surface_tool.add_index(render_mesh_indices[i]);
	
	# Tell surface_tool to generate tangent vectors for us.
	surface_tool.generate_tangents();
	
	# Get the mesh from surface_tool and update the mesh in mesh_instance.
	render_mesh = surface_tool.commit();
	mesh_instance.mesh = render_mesh;
	# ********************
	
	# Make the collision mesh
	# ********************
	# Clear any old data in surface_tool, and start making a Mesh in PRIMITIVE_TRIANGLES mode.
	surface_tool.clear();
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	# Go through every vertex in collision_mesh_vertices.
	for i in range(0, collision_mesh_vertices.size()):
		# Just add the vertex to the surface tool. Unlike with the render mesh, we do not
		# need to worry about it's normal, UV position, or anything else because all we need
		# for collision geometry is the vertices and the indices.
		surface_tool.add_vertex(collision_mesh_vertices[i]);
	
	# Go through every index in collision_mesh_indices.
	for i in range(0, collision_mesh_indices.size()):
		# Add the index to the surface tool.
		surface_tool.add_index(collision_mesh_indices[i]);
	
	# Get the mesh from the surface tool, and then generate a trimesh shape from the mesh and assign
	# that as the shape in collision_shape.
	collision_mesh = surface_tool.commit();
	collision_shape.shape = collision_mesh.create_trimesh_shape();
	# ********************


func make_voxel(x, y, z):
	# Do not bother trying to make a null/air voxel!
	if (voxels[x][y][z] == null or voxels[x][y][z] == -1):
		return;
	
	# Potentially create the TOP face for the voxel at X, Y, Z:
	# Check to see if there could be a voxel above this voxel...
	if (_get_voxel_in_bounds(x, y+1, z)):
		# Then check to see if the voxel above this voxel will cause this voxel to be rendered...
		if (_check_if_voxel_cause_render(x, y+1, z)):
			# If the voxel above this one causes a render, then add this voxel's TOP face.
			make_voxel_face(x, y, z, "TOP");
	# If there cannot be a voxel above this voxel...
	else:
		# Then render this voxel's TOP face.
		make_voxel_face(x, y, z, "TOP");
	# All of the other faces use the same logic as above, just different coordinates and we
	# render different faces according to those coordinates.
	
	# Potentially create the BOTTOM face for the voxel at X, Y, Z:
	if (_get_voxel_in_bounds(x, y-1, z)):
		if (_check_if_voxel_cause_render(x, y-1, z)):
			make_voxel_face(x, y, z, "BOTTOM");
	else:
		make_voxel_face(x, y, z, "BOTTOM");
	
	# Potentially create the EAST face for the voxel at X, Y, Z:
	if (_get_voxel_in_bounds(x+1, y, z)):
		if (_check_if_voxel_cause_render(x+1, y, z)):
			make_voxel_face(x, y, z, "EAST");
	else:
		make_voxel_face(x, y, z, "EAST");
	
	# Potentially create the WEST face for the voxel at X, Y, Z:
	if (_get_voxel_in_bounds(x-1, y, z)):
		if (_check_if_voxel_cause_render(x-1, y, z)):
			make_voxel_face(x, y, z, "WEST");
	else:
		make_voxel_face(x, y, z, "WEST");
	
	# Potentially create the NORTH face for the voxel at X, Y, Z:
	if (_get_voxel_in_bounds(x, y, z+1)):
		if (_check_if_voxel_cause_render(x, y, z+1)):
			make_voxel_face(x, y, z, "NORTH");
	else:
		make_voxel_face(x, y, z, "NORTH");
	
	# Potentially create the SOUTH face for the voxel at X, Y, Z:
	if (_get_voxel_in_bounds(x, y, z-1)):
		if (_check_if_voxel_cause_render(x, y, z-1)):
			make_voxel_face(x, y, z, "SOUTH");
	else:
		make_voxel_face(x, y, z, "SOUTH");


func _check_if_voxel_cause_render(x, y, z):
	# If the voxel voxel at the passed in position is a air/nothing voxel
	# then we will want to render voxels around it, so we return true.
	if (voxels[x][y][z] == null or voxels[x][y][z] == -1):
		return true;
	
	# If the voxel at the passed in position is NOT a air/nothing voxel...
	else:
		# Get the voxel's data from voxel_world.
		var tmp_voxel_data = voxel_world.get_voxel_data_from_int(voxels[x][y][z]);
		# If the voxel is transparent or is not solid, then we will want to render voxels
		# around it, so we return true.
		if (tmp_voxel_data.transparent == true or tmp_voxel_data.solid == false):
			return true;
	
	# If we have not returned true already, then this voxel most be solid and not transparent.
	# We return false because we do not need to render voxels around this voxel.
	return false;


func make_voxel_face(x, y, z, face):
	# Get the voxel data using the voxel ID stored at the passed in position in the voxels variable.
	var voxel_data = voxel_world.get_voxel_data_from_int(voxels[x][y][z]);
	
	# Get the UV position from the voxel data for the voxel at the passed in position.
	var uv_position = voxel_data.texture;
	
	# Account for the voxel's size by multiplying the passed in position by voxel_size.
	x = x * voxel_size;
	y = y * voxel_size;
	z = z * voxel_size;
	
	# Check to see if this voxel has a specific texture for the passed in face.
	if (voxel_data.has("texture_" + face) == true):
		# If it does, then use the texture stored in voxel_data for this face.
		uv_position = voxel_data["texture_" + face];
	
	# Based on which face we are making, call the correct function and pass in the position
	# of the voxel and the voxel data.
	if (face == "TOP"):
		_make_voxel_face_top(x, y, z, voxel_data);
	elif (face == "BOTTOM"):
		_make_voxel_face_bottom(x, y, z, voxel_data);
	elif (face == "EAST"):
		_make_voxel_face_east(x, y, z, voxel_data);
	elif (face == "WEST"):
		_make_voxel_face_west(x, y, z, voxel_data);
	elif (face == "NORTH"):
		_make_voxel_face_north(x, y, z, voxel_data);
	elif (face == "SOUTH"):
		_make_voxel_face_south(x, y, z, voxel_data);
	else:
		print ("ERROR: Unknown face: " + face);
		return;
	
	# NOTE: notice how we are adding the UVs and indices here instead of in the _make_voxel_face
	# functions. This is because regardless of the voxel, we will need to add the UVs and indices.
	# It is easier to add it here outside of those functions, as adding it to the _make_voxel_face
	# functions will add duplicate code and the process is the same for all voxel faces so we can
	# just do it here to save space and time.
	
	# Add the UV mapping for this voxel's face.
	# NOTE: the order which you add to render_mesh_uvs is important!
	# When we add vertices to render_mesh_vertices, we are adding them in the following order:
		# top left, top right, bottom right, bottom left
	# Which means we need to set the UV coordinates for these vertices in the same order
	# so the texture is stretched accross the voxel correctly.
	var v_texture_unit = voxel_world.voxel_texture_unit;
	render_mesh_uvs.append(Vector2( (v_texture_unit * uv_position.x), (v_texture_unit * uv_position.y) + v_texture_unit));
	render_mesh_uvs.append(Vector2( (v_texture_unit * uv_position.x) + v_texture_unit, (v_texture_unit * uv_position.y) + v_texture_unit));
	render_mesh_uvs.append(Vector2( (v_texture_unit * uv_position.x) + v_texture_unit, (v_texture_unit * uv_position.y)) );
	render_mesh_uvs.append(Vector2( (v_texture_unit * uv_position.x), (v_texture_unit * uv_position.y) ));
	
	# Add the triangles to render_mesh_indices.
	# NOTE: Like with the UV, the order is important!
	# The indices tell the surface tool how to connect the vertices to make triangles.
	render_mesh_indices.append(render_mesh_vertices.size() - 4);
	render_mesh_indices.append(render_mesh_vertices.size() - 3);
	render_mesh_indices.append(render_mesh_vertices.size() - 1);
	render_mesh_indices.append(render_mesh_vertices.size() - 3);
	render_mesh_indices.append(render_mesh_vertices.size() - 2);
	render_mesh_indices.append(render_mesh_vertices.size() - 1);
	
	# Add the collision triangles, but only if the voxel is solid.
	# Like with the other two, the order is important!
	if (voxel_data.solid == true):
		collision_mesh_indices.append(render_mesh_vertices.size() - 4);
		collision_mesh_indices.append(render_mesh_vertices.size() - 3);
		collision_mesh_indices.append(render_mesh_vertices.size() - 1);
		collision_mesh_indices.append(render_mesh_vertices.size() - 3);
		collision_mesh_indices.append(render_mesh_vertices.size() - 2);
		collision_mesh_indices.append(render_mesh_vertices.size() - 1);


func _make_voxel_face_top(x, y, z, voxel_data):
	# Add the four vertices that will make up the top face of the voxel.
	# We are using voxel_size as the offset from left->right and bottom->top so the voxels
	# are the same size as voxel_size.
	#
	# Remember: we are adding vertices in the following order:
		# top left, top right, bottom right, bottom left
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));
	
	# Next add the normal vectors for the four vertices.
	# Because this is the TOP face, facing the positive Y axis, we
	# set the normals to the positive Y axis.
	render_mesh_normals.append(Vector3(0, 1, 0));
	render_mesh_normals.append(Vector3(0, 1, 0));
	render_mesh_normals.append(Vector3(0, 1, 0));
	render_mesh_normals.append(Vector3(0, 1, 0));
	
	# If the voxel is solid...
	if (voxel_data.solid == true):
		# Then we need to add the four vertices for this voxel to the collision mesh.
		# This is exactly the same process as adding to render_mesh_vertices, but instead
		# we are adding to collision_mesh_vertices.
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z));

# See _make_voxel_top for an explanation on what is going on here.
# There are some minor changes to make a different voxel face (coordinates and normals), but
# otherwise everything is more or less the same!
func _make_voxel_face_bottom(x, y, z, voxel_data):
	render_mesh_vertices.append(Vector3(x, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z));
	render_mesh_vertices.append(Vector3(x, y, z));
	
	render_mesh_normals.append(Vector3(0, -1, 0));
	render_mesh_normals.append(Vector3(0, -1, 0));
	render_mesh_normals.append(Vector3(0, -1, 0));
	render_mesh_normals.append(Vector3(0, -1, 0));
	
	if (voxel_data.solid == true):
		collision_mesh_vertices.append(Vector3(x, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z));
		collision_mesh_vertices.append(Vector3(x, y, z));

# See _make_voxel_top for an explanation on what is going on here.
# There are some minor changes to make a different voxel face (coordinates and normals), but
# otherwise everything is more or less the same!
func _make_voxel_face_north(x, y, z, voxel_data):
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));
	
	render_mesh_normals.append(Vector3(0, 0, 1));
	render_mesh_normals.append(Vector3(0, 0, 1));
	render_mesh_normals.append(Vector3(0, 0, 1));
	render_mesh_normals.append(Vector3(0, 0, 1));
	
	if (voxel_data.solid == true):
		collision_mesh_vertices.append(Vector3(x, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));

# See _make_voxel_top for an explanation on what is going on here.
# There are some minor changes to make a different voxel face (coordinates and normals), but
# otherwise everything is more or less the same!
func _make_voxel_face_south(x, y, z, voxel_data):
	render_mesh_vertices.append(Vector3(x, y, z));
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z));
	
	render_mesh_normals.append(Vector3(0, 0, -1));
	render_mesh_normals.append(Vector3(0, 0, -1));
	render_mesh_normals.append(Vector3(0, 0, -1));
	render_mesh_normals.append(Vector3(0, 0, -1));
	
	if (voxel_data.solid == true):
		collision_mesh_vertices.append(Vector3(x, y, z));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z));

# See _make_voxel_top for an explanation on what is going on here.
# There are some minor changes to make a different voxel face (coordinates and normals), but
# otherwise everything is more or less the same!
func _make_voxel_face_east(x, y, z, voxel_data):
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z));
	render_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));
	render_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
	
	render_mesh_normals.append(Vector3(1, 0, 0));
	render_mesh_normals.append(Vector3(1, 0, 0));
	render_mesh_normals.append(Vector3(1, 0, 0));
	render_mesh_normals.append(Vector3(1, 0, 0));
	
	if (voxel_data.solid == true):
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y, z));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z));
		collision_mesh_vertices.append(Vector3(x + voxel_size, y + voxel_size, z + voxel_size));

# See _make_voxel_top for an explanation on what is going on here.
# There are some minor changes to make a different voxel face (coordinates and normals), but
# otherwise everything is more or less the same!
func _make_voxel_face_west(x, y, z, voxel_data):
	render_mesh_vertices.append(Vector3(x, y, z + voxel_size));
	render_mesh_vertices.append(Vector3(x, y, z));
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z));
	render_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));
	
	render_mesh_normals.append(Vector3(-1, 0, 0));
	render_mesh_normals.append(Vector3(-1, 0, 0));
	render_mesh_normals.append(Vector3(-1, 0, 0));
	render_mesh_normals.append(Vector3(-1, 0, 0));
	
	if (voxel_data.solid == true):
		collision_mesh_vertices.append(Vector3(x, y, z + voxel_size));
		collision_mesh_vertices.append(Vector3(x, y, z));
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z));
		collision_mesh_vertices.append(Vector3(x, y + voxel_size, z + voxel_size));


# This function will return the voxel at the passed in global position if it exists.
# Otherwise, it will return null.
func get_voxel_at_position(position):
	# Check to see if the global position is within the chunk's bounds...
	if (position_within_chunk_bounds(position) == true):
		# Convert the position so it is relative to this chunk's position.
		position = global_transform.xform_inv(position);
		
		# Divide position by voxel_size to account for large and small voxels, then floor
		# the position so that it is a whole number.
		position.x = floor(position.x / voxel_size);
		position.y = floor(position.y / voxel_size);
		position.z = floor(position.z / voxel_size);
		
		# Return the voxel ID at the position.
		return voxels[position.x][position.y][position.z];
	
	# Otherwise, return null as the position is not within this chunk.
	return null;

# This function will try to set the voxel ID at the passed in global position to the passed in voxel ID.
# If it sets the voxel, it will return true. If it cannot, it will return false.
func set_voxel_at_position(position, voxel):
	# Check to see if the global position is within the chunk's bounds... 
	if (position_within_chunk_bounds(position) == true):
		
		# Convert the position so it is relative to this chunk's position.
		position = global_transform.xform_inv(position);
		
		# Divide position by voxel_size to account for large and small voxels, then floor
		# the position so that it is a whole number.
		position.x = floor(position.x / voxel_size);
		position.y = floor(position.y / voxel_size);
		position.z = floor(position.z / voxel_size);

		for x in range(3, chunk_size_x-3):		
			for y in range(3, chunk_size_y-3):		
				for z in range(3, chunk_size_z-3):								
					voxels[x][y][z]=voxel;
		## Set the voxel at the passed in position to the passed in voxel ID.
		voxels[position.x][position.y][position.z] = voxel;
		
		# Update the mesh so that the new voxel is rendered.
		update_mesh();
		
		# Return true, as the voxel was placed successfully.
		return true;
	
	# If the position is not within this chunk, return false.
	return false;



# A helper function to check if the global position is within this chunk's bounds.
func position_within_chunk_bounds(position):
	# Check to make sure the X coordinate of the passed in position is within the bounds of this chunk.
	# We do this by making sure the X position is more than the global position of the chunk, and less
	# than the global position of the chunk plus the size of the chunk multiplied by the size of the voxels.
	if (position.x < global_transform.origin.x + (chunk_size_x * voxel_size) and position.x > global_transform.origin.x):
		# Check to make sure the Y coordinate of the passed in position is within the bounds of this chunk.
		if (position.y < global_transform.origin.y + (chunk_size_y * voxel_size) and position.y > global_transform.origin.y):
			# Check to make sure the Z coordinate of the passed in position is within the bounds of this chunk.
			if (position.z < global_transform.origin.z + (chunk_size_z * voxel_size) and position.z > global_transform.origin.z):
				# If the position is within the chunk's bounds on all three coordinates, then return true.
				return true;
	
	# If any of the above checks fail, then return false as the position is not within this chunk's bounds.
	return false;


# A helper function to check if the position is within the bounds of the voxels three dimensional list.
func _get_voxel_in_bounds(x,y,z):
	# Check to see if the X value is too small, or too large. If it is, return false.
	if (x < 0 || x > chunk_size_x-1):
		return false;
	# Check to see if the Y value is too small, or too large. If it is, return false.
	elif (y < 0 || y > chunk_size_y-1):
		return false;
	# Check to see if the Z value is too small, or too large. If it is, return false.
	elif (z < 0 || z > chunk_size_z-1):
		return false;
	
	# If all three positions are within the bounds the voxels list, then return true.
	return true;


