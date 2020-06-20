extends Node2D

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#var main_level = load("res://MainLevel.tscn").instance()
	#call_deferred("add_child", main_level)
	pass

func _process(delta):
	if(camera == null):		
		camera = get_tree().get_nodes_in_group("camera")[0]
	$Node2D.position = camera.position
	
