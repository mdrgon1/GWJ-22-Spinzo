extends State

func enter(_args):
	print("Swinging")
	root_state.vel_lerp = 1
	root_state.target_velocity = Vector2(0, 0)
	root_state.velocity = Vector2(0, 0)
