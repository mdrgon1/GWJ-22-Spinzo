extends KinematicBody2D

const UP = Vector2(0, -1)

onready var movement = $Movement
onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	movement.init()

func _physics_process(delta):
	
	movement.update(delta);
	movement.velocity = move_and_slide(movement.velocity, UP)
