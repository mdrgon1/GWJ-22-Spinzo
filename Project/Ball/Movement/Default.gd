extends State

const MAX_RADIUS = 25
const MIN_RADIUS = 1
const RADIUS_LERP = 1
const MAX_RPS = 1.2
const MIN_RPS = 0.3
const RPS_LERP = 0.6

var target_radius : float
var rotations_per_sec : float

func enter(_args):
	target_radius = MAX_RADIUS
	rotations_per_sec = MIN_RPS

func run(delta):
	if(Input.is_action_pressed("throw_ball")):
		target_radius += (MIN_RADIUS - target_radius) * RADIUS_LERP * delta
		rotations_per_sec += (MAX_RPS - rotations_per_sec) * RPS_LERP * delta
	
	if(Input.is_action_just_released("throw_ball")):
		return "Throwing"
	
	print(target_radius, ", ", rotations_per_sec)
	
	rotate(delta)

# rotate the ball around player like normal
func rotate(delta):
	var tangent_velocity = (owner.to_player().length() * 2 * PI) * (rotations_per_sec)
	
	# at a right angle to the vector from player to ball
	var tangent_vector = Vector2(owner.to_player().y, -owner.to_player().x).normalized()
	
	# points the velocity towards target radius, between player and ball
	root_state.velocity = owner.player.position - (owner.to_player().normalized() * target_radius) - owner.position
	
	# add tangent velocity
	root_state.velocity += tangent_velocity * tangent_vector
	
	# somewhat adjuct for player movement
	root_state.velocity += owner.player.movement.velocity * 0.3
