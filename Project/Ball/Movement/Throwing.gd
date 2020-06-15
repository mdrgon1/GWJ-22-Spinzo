extends State

const TIME_TO_RECHARGE = 0.1
const MAX_DISTANCE = 170
var timer : float

func enter(_args):
	timer = 0

func run(delta):
	
	if(Input.is_action_just_released("throw_ball")):
		return "Default"

	#if throw ball is held long enough, revert to a charging state
	if(Input.is_action_pressed("throw_ball")):
		timer += delta
	else:
		timer = 0
	
	if(timer >= TIME_TO_RECHARGE):
		return "Default"
		
	if(owner.to_player().length() >= MAX_DISTANCE):
		return "Default"
