extends State

func enter(_args):
	root_state.vel_lerp = 0.2
	print("running")

func run(delta):
	root_state.target_velocity.x = root_state.get_input_vector().x * root_state.HOR_SPEED #normal movement
	
	if(Input.is_action_pressed("jump")):
		return "Jumping"
		
	if(!owner.is_on_floor()):
		return "Falling"
	
	if(Input.is_key_pressed(KEY_X)):
		return "Swinging"
