extends Camera2D

const Y_OFFSET = -12
const Y_BUFFER = 30
const OFFSET_LIMIT = 5
const POS_LERP = 6

var rpm : int
var min_height : float

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var ball_default_state = ball.movement.substates_map["Default"]
onready var rpm_counter = [$RPM1, $RPM2, $RPM3]

func _enter_tree():
	_set_current(true)

func reset():
	position = Vector2(0, 0)
	min_height = 0

func _process(delta):
	# follow player
	min_height = min(min_height, position.y)
	var target_position = player.position
	target_position.y = min(min_height + Y_BUFFER, player.position.y + Y_OFFSET)
	if((position - target_position).length() > OFFSET_LIMIT):
		var to_target = target_position - position
		var new_target = position + to_target.normalized() * (to_target.length() - OFFSET_LIMIT)
		position += (new_target - position) * POS_LERP * delta
	
	# update rpm counter
	if(ball.movement.current_state == ball_default_state):
		rpm = ball_default_state.rotations_per_sec * ball_default_state.rps_multiplier * 60
	
	for i in range(3):
		var num = int(rpm / pow(10, i)) % 10
		rpm_counter[i].set_text(String(num))
