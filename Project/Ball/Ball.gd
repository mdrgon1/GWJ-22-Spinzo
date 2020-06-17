extends KinematicBody2D

const AIM_LINE_LENGTH = 100

var time_dilation = 1

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var movement = $Movement

func _ready():
	movement.set_root_state(movement)
	movement.init()

func _draw():
	if(movement.current_state == $Movement/Default && Input.is_action_pressed("aim")):
		draw_line(Vector2(0, 0), movement.velocity.normalized() * AIM_LINE_LENGTH, Color(1, 1, 1), 1.5)

func _physics_process(delta):
	
	time_dilation = get_node("/root/Main").time_dilation
	delta *= time_dilation
	
	# draw aiming line thing
	update()
	
	movement.update(delta)
	movement.velocity = move_and_slide(movement.velocity * time_dilation) / time_dilation
	
func to_player():
	return player.position - position
