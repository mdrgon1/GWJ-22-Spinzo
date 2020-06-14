extends KinematicBody2D

var vel : Vector2

onready var movement = $Movement

func _ready():
	movement.enter()

func _physics_process(delta):
	
	movement.update();
	move_and_slide(movement.velocity)
