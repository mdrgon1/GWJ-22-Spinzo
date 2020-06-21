extends Camera2D

const Y_OFFSET = 0

var rpm : int

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var ball_default_state = ball.movement.substates_map["Default"]
onready var rpm_counter = [$RPM1, $RPM2, $RPM3]

func _enter_tree():
	_set_current(true)

func _process(delta):
	if(ball.movement.current_state == ball_default_state):
		rpm = ball_default_state.rotations_per_sec * ball_default_state.rps_multiplier * 60
	
	for i in range(3):
		var num = int(rpm / pow(10, i)) % 10
		rpm_counter[i].set_text(String(num))
		
	position.y = min(position.y, player.position.y + Y_OFFSET)
	position = player.position
