extends State

func enter(_args):
	print("Swinging")
	root_state.vel_lerp = 1
	root_state.target_velocity = Vector2(0, 0)
	root_state.velocity = Vector2(0, 0)

func run(delta):
	pass

#func run(delta):
#
#	# get target radius and rps from ball, as well as target position
#	#var target_radius = owner.ball.movement.default.target_radius
#	#var rotations_per_second = owner.ball.movement.default.rotations_per_second
#	#rotations_per_second *= owner.ball.movement.default.rps_multiplier
#
#	var target_radius = 10
#	var rotations_per_second = 100
#
#	var target_pos = owner.position
#
#	# center target pos around ball and rotate a given amount
#	target_pos -= owner.ball.position
#
#	target_pos = target_pos.rotated(rotations_per_second * 2 * PI * delta)
#
#	# scale target position to target radius
#	target_pos *= target_radius / target_pos.length()
#
#	# move target position back
#	target_pos += owner.ball.position
#
#	root_state.target_velocity = target_pos - owner.position
#
#	if(!Input.is_key_pressed(KEY_X)):
#		return "Falling"
