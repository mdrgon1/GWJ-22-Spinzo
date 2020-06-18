extends KinematicBody2D

const SPEED = 30
const GRAVITY = 150
const AGRO_DIST = 80

var velocity : = Vector2(0, 0)

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	
	if((player.position - position).length() <= AGRO_DIST):
		velocity.x = sign(player.position.x - position.x) * SPEED
	else:
		velocity.x = 0
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity)

func die():
	queue_free()
