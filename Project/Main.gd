extends Node2D

const DISTORT_LERP = 4

var camera : Camera2D
var ball : KinematicBody2D
var target_distort = 1
var distort = 1

onready var post_pro = $"Node2D/Control3/post-process"
onready var spread_base = post_pro.material.get_shader_param("chrom_spread")
onready var chrom_base = post_pro.material.get_shader_param("chrom_amount")

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_level = load("res://MainLevel.tscn").instance()
	call_deferred("add_child", main_level)

func _process(delta):
	if(camera == null):
		camera = get_tree().get_nodes_in_group("camera")[0]
	if(ball == null):
		ball = get_tree().get_nodes_in_group("ball")[0]
	
	if(ball.movement.current_state == ball.movement.substates_map["Default"]):
		target_distort = ball.movement.substates_map["Default"].rotations_per_sec
		target_distort *= ball.movement.substates_map["Default"].rps_multiplier
		target_distort /= ball.movement.substates_map["Default"].MIN_RPS
	
	distort += (target_distort - distort) * DISTORT_LERP * delta
	post_pro.material.set_shader_param("chrom_spread", spread_base * (1 + 0.2 * (1 - distort)))
	post_pro.material.set_shader_param("chrom_amount", chrom_base / (1 + 0.1 * (1 - distort)))
	
	$Node2D.position = camera.position
	
