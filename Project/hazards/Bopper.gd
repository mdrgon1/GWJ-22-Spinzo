extends KinematicBody2D

const SPEED = 30
const GRAVITY = 150
const AGRO_DIST = 80
const KNOCKBACK_FORCE = 150

var velocity : = Vector2(0, 0)

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var camera = get_node("/root/Main/Camera2D")

func _physics_process(delta):
	
	if((player.position - global_position).length() <= AGRO_DIST):
		velocity.x = sign(player.position.x - global_position.x) * SPEED
	else:
		velocity.x = 0
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity)
	
	# despawn if it falls below the camera
	if(position.y >= camera.position.y + get_node("/root/Main").DESPAWN_RECT.end.y):
		queue_free()

func _on_Area2D_body_entered(body):
	if body == player:
		player.knockback(calc_knockback())
	if (body == ball && ball.is_lethal):
		ball.movement.hit()
		kill()
	

func calc_knockback():
	var knockback = (player.position - global_position)
	knockback.y -= 2
	knockback.y = sign(knockback.y)
	knockback.x = sign(knockback.x)
	knockback = knockback.normalized() * KNOCKBACK_FORCE
	return knockback

func kill():
	queue_free()
