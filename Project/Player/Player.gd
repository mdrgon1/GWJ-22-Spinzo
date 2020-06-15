extends KinematicBody2D

const UP = Vector2(0, -1)

onready var movement = $Movement

func _ready():
	movement.init()

func _physics_process(delta):
	
	movement.update(delta);
	movement.velocity = move_and_slide(movement.velocity, UP)
