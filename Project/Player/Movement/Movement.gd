extends State

const GRAVITY = 150
const MAX_FALL_SPEED = 80
const HOR_SPEED = 80 # characters horizontal movement speed

var velocity = Vector2(0, 0)
var target_velocity = Vector2(0, 0)
var vel_lerp : float = 0	# I will set this in each states enter() which is hacky but I see no one here to stop me

func _ready():
	set_root_state(self)	# set root state of entire machine to self

func run(delta : float):
	velocity += (target_velocity - velocity) * vel_lerp * delta * 60	# lerp velocity to the target velocity

# update velocity and target velocity to byass slerping
func move_directly(vec : Vector2):
	velocity += vec
	target_velocity += vec

func get_input_vector():
	var vec = Vector2(0, 0);
	vec.x += Input.get_action_strength("move_right")
	vec.x -= Input.get_action_strength("move_left")
	vec.y += Input.get_action_strength("move_down")
	vec.y -= Input.get_action_strength("jump")
	
	return vec
