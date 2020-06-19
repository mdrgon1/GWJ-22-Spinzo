extends State

func enter(_args):
	root_state.vel_lerp = 0.2
	print("running")

func run(delta):
	if(root_state.get_input_vector().x == 0):
		owner.sprite.play("Idle")
	else:
		owner.sprite.play("Run")
	
	root_state.target_velocity.x = root_state.get_input_vector().x * root_state.HOR_SPEED #normal movement
	root_state.velocity.y = 1 # just to keep player in running state
	
	if(Input.is_action_pressed("jump")):
		return "Jumping"
		
	if(!owner.is_on_floor()):
		return "Falling"
