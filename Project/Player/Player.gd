extends KinematicBody2D

const UP = Vector2(0, -1)

onready var movement = $Movement
onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	movement.init()

func _physics_process(delta):
	
	var time_dilation = get_node("/root/Main").time_dilation
	delta *= time_dilation
	
	movement.update(delta);
	movement.velocity = move_and_slide(movement.velocity * time_dilation, UP) / time_dilation
