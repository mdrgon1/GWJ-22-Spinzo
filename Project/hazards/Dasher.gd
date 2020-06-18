extends KinematicBody2D

const SPEED = 40
const SPEED_LERP = 1
const DASH_SPEED = 150
const GRAVITY = 150
const AGRO_DIST = 80
const KNOCKBACK_FORCE = 200

var target_velocity : = Vector2(0, 0)
var velocity : = Vector2(0, 0)

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var attack_area = $AttackArea

func _physics_process(delta):
	
	if((player.position - global_position).length() <= AGRO_DIST):
		target_velocity.x = sign(player.position.x - global_position.x) * SPEED
	else:
		target_velocity.x = 0
	velocity.y += GRAVITY * delta
	
	# lerp velocity to target_velocity
	velocity.x += (target_velocity.x - velocity.x) * SPEED_LERP * delta
	
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body == player:
		player.knockback(calc_knockback())
	if (body == ball && ball.is_lethal):
		ball.movement.hit()
		kill()

func calc_knockback():
	var knockback = Vector2(sign(player.position.x - global_position.x), 0)
	knockback *= KNOCKBACK_FORCE
	return knockback

func kill():
	queue_free()

func _on_AttackArea_body_entered(body):
	if(body == player):
		# dash towards the player
		velocity.x = sign(player.position.x - global_position.x) * DASH_SPEED
