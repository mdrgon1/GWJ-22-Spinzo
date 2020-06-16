extends Camera2D

const Y_OFFSET = 0

onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	#position.y = min(position.y, player.position.y + Y_OFFSET)
	position = player.position
