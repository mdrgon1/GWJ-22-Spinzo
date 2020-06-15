extends State

const GRAVITY_MULTIPLIER = 0.4
const JUMP_FORCE = 60

func enter(_args):
	print("jumping")
	root_state.velocity.y = -JUMP_FORCE
	root_state.target_velocity.y = -JUMP_FORCE
	root_state.vel_lerp = 0.08

func run(delta):
	root_state.target_velocity.x = root_state.get_input_vector().x * root_state.HOR_SPEED #normal movement
	
	# gwavity
	if(root_state.velocity.y < root_state.MAX_FALL_SPEED):
		root_state.move_directly(Vector2(0, root_state.GRAVITY * GRAVITY_MULTIPLIER * delta))
	
	if(owner.is_on_floor()):
		return "Running"
	print(root_state.velocity)
	if(root_state.velocity.y > 0 || !Input.is_action_pressed("jump")):
		return "Falling"
