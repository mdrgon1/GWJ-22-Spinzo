extends KinematicBody2D

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var movement = $Movement

func _ready():
	movement.init()
	movement.set_root_state(movement)

func _physics_process(delta):
	movement.update(delta)
	
	movement.velocity = move_and_slide(movement.velocity)
	
func to_player():
	return player.position - position
