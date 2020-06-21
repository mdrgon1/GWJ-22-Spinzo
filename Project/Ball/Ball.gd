extends KinematicBody2D

const AIM_LINE_LENGTH = 100
const IS_LETHAL_THRESHOLD = 100

export var charge : AudioStream
export var shoot : AudioStream

var time_dilation = 1
var is_lethal = false

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var movement = $Movement
onready var sprite = $Sprite
onready var sound = $Sound

func _ready():
	movement.set_root_state(movement)
	movement.init()

func reset():
	position = Vector2(0, 3)
	movement.velocity = Vector2(0, 0)
	movement.update_state("Default")

func _draw():
	if(movement.current_state == $Movement/Default && Input.is_action_pressed("aim")):
		draw_line(Vector2(0, 0), movement.velocity.normalized() * AIM_LINE_LENGTH, Color(1, 1, 1), 1.5)

func _physics_process(delta):
	
	# update rps multiplier
	var multiplier = min(-0.0007 * player.position.y + 1, 1.7)
	movement.substates_map["Default"].rps_multiplier = multiplier
	print(multiplier)
	
	time_dilation = owner.time_dilation
	delta *= time_dilation
	
	# draw aiming line thing
	update()
	
	movement.update(delta)
	movement.velocity = move_and_slide(movement.velocity * time_dilation) / time_dilation
	
	# check that the ball is lethal
	is_lethal = (movement.velocity.length()) / time_dilation >= IS_LETHAL_THRESHOLD
	if(is_lethal):
		$Sprite.set_self_modulate(Color(1, 0, 0))
	else:
		$Sprite.set_self_modulate(Color(1, 1, 1))
	
func to_player():
	return player.position - position
