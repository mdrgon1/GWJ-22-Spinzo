extends State

const MAX_RADIUS = 25
const MIN_RADIUS = 10
const RADIUS_LERP = 1
const MAX_RPS = 1.2
const MIN_RPS = 0.3
const RPS_LERP = 0.6
const VELOCITY_LERP = 1
const CHARGE_THRESHOLD = 0.3 # how long does a ball need to be charge before it can be thrown

var target_radius : float
var rotations_per_sec : float
var rps_multiplier : float = 1
var latched : bool	# keep track of whether or the ball is latched on to something
var charge_timer : float

func enter(_args):
	charge_timer = 0
	if(_args.size() != 0):
		latched = _args[0]
	else:
		latched = false
	
	target_radius = MAX_RADIUS
	
	# start rps at what it actually is, then lerp to MIN_RPS
	var tangent_velocity = root_state.velocity.project(get_tangent()).length()
	rotations_per_sec = tangent_velocity / (owner.to_player().length() * 2 * PI)

func run(delta):
	if(Input.is_action_just_released("throw_ball") && charge_timer >= CHARGE_THRESHOLD):
		return ["Throwing", latched]
	
	if(Input.is_action_pressed("throw_ball")):	# lerp to MIN_RADIUS and MAX_RPS
		target_radius += (MIN_RADIUS - target_radius) * RADIUS_LERP * delta
		rotations_per_sec += (MAX_RPS - rotations_per_sec) * RPS_LERP * delta
		charge_timer += delta
	else:	#lerp to MIN_RPS and MAX_RADIUS
		target_radius += (MAX_RADIUS - target_radius) * RADIUS_LERP * delta
		rotations_per_sec += (MIN_RPS - rotations_per_sec) * RPS_LERP * delta
		charge_timer = 0
	
	rotate(delta)

# at a right angle to the vector from player to ball
func get_tangent():
	return Vector2(owner.to_player().y, -owner.to_player().x).normalized()

# rotate the ball around player like normal
func rotate(delta):
	var tangent_velocity = (owner.to_player().length() * 2 * PI) * (rotations_per_sec * rps_multiplier)
	
	# points the velocity towards target radius
	root_state.velocity = owner.player.position - (owner.to_player().normalized() * target_radius) - owner.position
	if(root_state.velocity.length() >= MIN_RADIUS):	# cap radial velocity
		root_state.velocity = root_state.velocity.normalized() * MIN_RADIUS
	
	# adjust to account for centripedal force or something
	root_state.velocity *= root_state.velocity.length()
	root_state.velocity *= pow(rps_multiplier, 2)
	
	# add tangent velocity
	root_state.velocity += tangent_velocity * get_tangent()
	
	if(latched):
		owner.player.movement.target_velocity = -root_state.velocity * 1.2	# increase player velocity just so it feels a little nicer
		root_state.velocity = Vector2(0, 0)
	else:
		# somewhat adjust for player movement
		root_state.velocity += owner.player.movement.velocity * 0.3
