extends State

func enter(_args):
	owner.sprite.play("Fall")
	print("falling")
	root_state.vel_lerp = 0.06

func run(delta : float):
	root_state.target_velocity.x = root_state.get_input_vector().x * root_state.HOR_SPEED #normal movement
	
	# gwavity
	if(root_state.velocity.y < root_state.MAX_FALL_SPEED):
		root_state.move_directly(Vector2(0, root_state.GRAVITY * delta))
	
	if(owner.is_on_floor()):
		return "Running"
