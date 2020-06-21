extends State

func enter(_args):
	owner.sound.stream = owner.walking
	root_state.vel_lerp = 0.2
	print("running")

func run(delta):
	if(root_state.get_input_vector().x == 0):
		owner.sound.playing = false
		owner.sprite.play("Idle")
	else:
		if(!owner.sound.playing):
			owner.sound.playing = true
		owner.sprite.play("Run")
	
	root_state.target_velocity.x = root_state.get_input_vector().x * root_state.HOR_SPEED #normal movement
	root_state.velocity.y = 10 # just to keep player in running state
	
	if(Input.is_action_pressed("jump")):
		return "Jumping"
		
	if(!owner.is_on_floor()):
		return "Falling"

func exit():
	owner.sound.playing = false
