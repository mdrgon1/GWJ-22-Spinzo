extends State

const TIME_TO_RECHARGE = 0.1
const MAX_TIME = 600	# how long the ball travels for before it returns (in msec)

var time_thrown : float
var timer : float	# tracks how long "throw ball" has been pressed for

func enter(_args):
	owner.player.movement.update_state("Falling")
	
	time_thrown = OS.get_ticks_msec()
	timer = 0

func run(delta):
	
	if(root_state.velocity == Vector2(0, 0)):
		return ["Default", false]
	
	if(Input.is_action_just_released("throw_ball")):
		return ["Default", false]

	#if throw ball is held long enough, revert to a charging state
	if(Input.is_action_pressed("throw_ball")):
		timer += delta
	else:
		timer = 0
	
	if(timer >= TIME_TO_RECHARGE):
		return ["Default", false]
		
	if((OS.get_ticks_msec() - time_thrown) >= MAX_TIME):
		return ["Default", false]
	
	if(Input.is_key_pressed(KEY_X)):
		owner.player.movement.update_state("Swinging")	#force player into swinging state
		return ["Default", true]
