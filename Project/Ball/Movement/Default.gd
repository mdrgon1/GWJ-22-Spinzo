extends State

const MAX_RADIUS = 25
const MIN_RADIUS = 1
const RADIUS_LERP = 1
const MAX_RPS = 1.2
const MIN_RPS = 0.3
const RPS_LERP = 0.6
const VELOCITY_LERP = 1

var target_radius : float
var rotations_per_sec : float
var rps_multiplier : float = 1.1

func enter(_args):
	target_radius = MAX_RADIUS
	
	# start rps at what it actually is, then lerp to MIN_RPS
	var tangent_velocity = root_state.velocity.project(get_tangent()).length()
	rotations_per_sec = tangent_velocity / (owner.to_player().length() * 2 * PI)

func run(delta):
	if(Input.is_action_pressed("throw_ball")):	# lerp to MIN_RADIUS and MAX_RPS
		target_radius += (MIN_RADIUS - target_radius) * RADIUS_LERP * delta
		rotations_per_sec += (MAX_RPS - rotations_per_sec) * RPS_LERP * delta
	else:	#lerp to MIN_RPS
		rotations_per_sec += (MIN_RPS - rotations_per_sec) * RPS_LERP * delta
	
	if(Input.is_action_just_released("throw_ball")):
		return "Throwing"
	
	print(target_radius, ", ", rotations_per_sec)
	
	rotate(delta)

# at a right angle to the vector from player to ball
func get_tangent():
	return Vector2(owner.to_player().y, -owner.to_player().x).normalized()

# rotate the ball around player like normal
func rotate(delta):
	var tangent_velocity = (owner.to_player().length() * 2 * PI) * (rotations_per_sec * rps_multiplier)
	
	# points the velocity towards target radius, between player and ball
	root_state.velocity = owner.player.position - (owner.to_player().normalized() * target_radius) - owner.position
	
	# add tangent velocity
	root_state.velocity += tangent_velocity * get_tangent()
	
	# somewhat adjuct for player movement
	root_state.velocity += owner.player.movement.velocity * 0.3
