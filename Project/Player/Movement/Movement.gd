extends State

const GRAVITY = 10

var velocity : Vector2
var target_velocity : Vector2
var vel_slerp : float

func _ready():
	set_root_state(self)	#set root state of entire machine to self

func run(delta):
	velocity = velocity.slerp(target_velocity, vel_slerp)	#lerp velocity to the target velocity
