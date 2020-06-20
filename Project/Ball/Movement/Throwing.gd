extends State

const TIME_TO_RECHARGE = 0.1
const MAX_TIME = 700	# how long the ball travels for before it returns (in msec)

var time_thrown : float
var timer : float	# tracks how long "throw ball" has been pressed for

func enter(_args):
	if(_args.size() != 0):
		if(_args[0]):# check if the ball was just latched
			owner.player.movement.update_state("Falling")
			
			# launch the player a little bit
			owner.player.movement.velocity *= 2
			owner.player.movement.target_velocity *= 1.5
	
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
	
	if(timer >= TIME_TO_RECHARGE / owner.time_dilation):
		return ["Default", false]
		
	if((OS.get_ticks_msec() - time_thrown) >= MAX_TIME):
		return ["Default", false]

func start_swinging():
	owner.player.movement.update_state("Swinging")	#force player into swinging state
	owner.movement.update_state(["Default", true])
