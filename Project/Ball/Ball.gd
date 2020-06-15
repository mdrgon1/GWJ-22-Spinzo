extends KinematicBody2D

onready var player = get_tree().get_nodes_in_group("player")[0]

var velocity : Vector2
var target_radius = 10

func _physics_process(delta):
	rotate(delta)
	
# rotate the ball around player like normal
func rotate(_delta):	
	var rotations_per_sec = 0.5
	var tangent_velocity = (to_player().length() * 2 * PI) * (rotations_per_sec)
	
	# at a right angle to the vector from player to ball
	var tangent_vector = Vector2(to_player().y, -to_player().x).normalized()
	
	# points the velocity towards target radius, between player and ball
	velocity = player.position - (to_player().normalized() * target_radius) - position
	
	# add tangent velocity
	velocity += tangent_velocity * tangent_vector
	
	velocity = move_and_slide(velocity)

func to_player():
	return player.position - position
