extends State

var target_radius = 10

func run(_delta):
	rotate(_delta)

# rotate the ball around player like normal
func rotate(_delta):	
	var rotations_per_sec = 0.5
	var tangent_velocity = (owner.to_player().length() * 2 * PI) * (rotations_per_sec)
	
	# at a right angle to the vector from player to ball
	var tangent_vector = Vector2(owner.to_player().y, -owner.to_player().x).normalized()
	
	# points the velocity towards target radius, between player and ball
	root_state.velocity = owner.player.position - (owner.to_player().normalized() * target_radius) - owner.position
	
	# add tangent velocity
	root_state.velocity += tangent_velocity * tangent_vector
	
	# somewhat adjuct for player movement
	root_state.velocity += owner.player.movement.velocity * 0.3
