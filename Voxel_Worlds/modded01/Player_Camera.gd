
extends Spatial

# The speed the player moves at normally.
const NORMAL_SPEED = 8;
# The speed the player moves at when the shift button is held.
const SHIFT_SPEED = 12;

# A variable for tracking whether the control key has been pressed/is-down.
var keyboard_control_down = false;

# The camera for the game.
var view_cam;

# The amount of mouse sensitivity.
const MOUSE_SENSITIVITY = 0.15;
# The minimum and maximum angles the player can look at on the X axis
# (Use a positive value, as we'll use negative MIN_MAX_ANGLE for the minimum value!)
const MIN_MAX_ANGLE = 85;

# A variable for tracking whether we need to do a raycast and add/remove a voxel.
var do_raycast = false;
# A variable for tracking whether we should remove a voxel or add a voxel to the terrain.
var mode_remove_voxel = false;

# A NodePath to the voxel world, and a variable to hold the voxel world.
# We need this so we can change the voxels in the world.
export (NodePath) var path_to_voxel_world;
var voxel_world;

# The name of the currently selected voxel.
var current_voxel = "Cobble";

# A exported variable to hold the object we'll spawn when the control button is pressed.
export (PackedScene) var physics_object_scene;


func _ready():
	# Get the view camera and the path to the voxel world.
	view_cam = get_node("View_Camera");
	voxel_world = get_node(path_to_voxel_world);


func _process(delta):
	
	# If the right mouse button is pressed/down...
	#if (Input.is_mouse_button_pressed(BUTTON_RIGHT) == true):
	if (Input.is_key_pressed(KEY_ALT) == true):
		# If the mouse mode is not MOUSE_MODE_CAPTURED...
		if (Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED):
			# Then set the mouse mode to MOUSE_MODE_CAPTURED so the player
			# can navigate through the world FPS flying camera style.
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	# If the right mouse is not pressed/down...
	else:
		# If the mouse mode is not MOUSE_MODE_VISIBLE...
		if (Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE):
			# Set the mouse mode to MOUSE_MODE_VISIBLE so the player can use
			# the mouse cursor to place voxels.
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	
	
	# If the mouse mode is set to MOUSE_MODE_CAPTURED...
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		# Then we want to allow for FPS style camera movement.
		# First we make a new variable for storing how fast the camera will be moving
		var speed = NORMAL_SPEED;
		
		# If the shift key is pressed/held-down, then we want to go at SHIFT_SPEED
		# instead of NORMAL_SPEED.
		if (Input.is_key_pressed(KEY_SHIFT)):
			speed = SHIFT_SPEED;
		
		# Next we make a Vector3 to store the direction the player wants to move towards.
		var dir = Vector3(0,0,0);
		# Then based on which keys are pressed, we update the variable accordingly.
		if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
			dir.z = -1;
		if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
			dir.z = 1;
		if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
			dir.x = -1;
		if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
			dir.x = 1;
		if (Input.is_key_pressed(KEY_SPACE)):
			dir.y = 1;
		
		# Normalize the direction the player wants to go towards so we can smooth diagonal movement.
		dir = dir.normalized();
		
		# Finally, move the player according to the direction(s) they want to go.
		# First, we move the player along the Z axis, which will move them forward/back.
		global_translate(view_cam.global_transform.basis.z * dir.z * delta * speed);
		# Then we move the player along the X axis, which will move them right/left.
		global_translate(view_cam.global_transform.basis.x * dir.x * delta * speed);
		# Finally, we move the player along the Y axis, which will move them up/down.
		global_translate(Vector3(0, 1, 0) * dir.y * delta * speed);
	
	
	# If the control key is pressed...
	if (Input.is_key_pressed(KEY_CONTROL)):
		# Check to see if keyboard_control_down is false. If it is, then that means the
		# control key has just been pressed.
		if (keyboard_control_down == false):
			# Set keyboard_control_down to true, since it has now been pressed.
			keyboard_control_down = true;
			
			# Make a new instance of whatever scene physics_object_scene points to.
			var new_obj = physics_object_scene.instance();
			# Set it's transform to the transform of the player camera.
			new_obj.global_transform = view_cam.global_transform;
			# Add the newly instanced scene as a child of the parent of the this node.
			get_parent().add_child(new_obj);
	# If the control key is not pressed.
	else:
		# Set keyboard_control_down to false so we know when it is pressed again.
		keyboard_control_down = false;


func _physics_process(delta):
	# Check to see if we need to send a raycast...
	if (do_raycast == true):
		# Set do_raycast to false so we only send one raycast at a time.
		do_raycast = false;
		
		# Get the space state, the origin of the ray, and the end point of the ray.
		# See (https://docs.godotengine.org/en/3.0/tutorials/physics/ray-casting.html) for more info on what this does.
		var space_state = get_world().direct_space_state;
		var from = view_cam.project_ray_origin(get_viewport().get_mouse_position());
		var to = from + view_cam.project_ray_normal(get_viewport().get_mouse_position()) * 100;
		
		# Get a result from the raycast.
		var result = space_state.intersect_ray(from, to, [self]);
		# If the raycast hit something...
		if (result):
			# If we are not removing a voxel...
			if (mode_remove_voxel == false):
				# Then add a voxel to voxel_world. Use the positive normal result so the voxel is added on top
				# of whatever the raycast hit.
				voxel_world.set_world_voxel(result.position + (result.normal/2), voxel_world.get_voxel_int_from_string(current_voxel));

			# If we are removing a voxel...
			else:
				# The remove a voxel from voxel_world. Use the negative normal result so the voxel removed
				# is slight inside of whatever the raycast hit.
				voxel_world.set_world_voxel(result.position - (result.normal/2), null);


# NOTE: Only called when a input event is NOT captured and processed by other nodes.
func _unhandled_input(event):
	
	# Check to see if the cursor is captured...
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Check to see if the event is a mouse motion event (so we should rotate the camera)
		if event is InputEventMouseMotion:
			
			# Convert mouse movement to camera rotation.
			view_cam.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
			self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
			
			# Clamp the rotation on the X axis so you cannot look upside down.
			var camera_rot = view_cam.rotation_degrees
			camera_rot.x = clamp(camera_rot.x, -MIN_MAX_ANGLE, MIN_MAX_ANGLE)
			view_cam.rotation_degrees = camera_rot
	
	# If the mouse is not captured...
	else:
		# Check to see if the event is a mouse button event...
		#if (Input.is_mouse_button_pressed(BUTTON_LEFT) == true):
		#	do_raycast = true;
	#	mode_remove_voxel = false;		
		if (event is InputEventMouseButton):
			# If the mouse button was just pressed...
			if (event.pressed == true):
				# Add a voxel if the button is a left mouse button click.
				if (event.button_index == BUTTON_LEFT):
					do_raycast = true;
					mode_remove_voxel = false;
				# Remove a voxel if the button is a middle mouse button click.
				if (event.button_index == BUTTON_MIDDLE):
					do_raycast = true;
					mode_remove_voxel = true;


