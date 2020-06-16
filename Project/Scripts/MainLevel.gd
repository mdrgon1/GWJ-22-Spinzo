extends Node

const IN_FRAME_BUFFER = 0

var num_levels = 3
var active_levels = []

onready var camera : Camera2D = $Camera2D

func _process(delta):

	for level in active_levels:
		var lower_bound = camera.position.y + ProjectSettings.get_setting("display/window/size/height") * camera.zoom.y + IN_FRAME_BUFFER
		if(level.position.y > lower_bound):
			level.queue_free()
			active_levels.erase(level)
	
	if(Input.is_action_just_pressed("throw_ball")):
		create_level(Vector2(randi() % 20, randi() % 20 + 50))
	

# create a random level at a given position
func create_level(position : Vector2):
	var level_index = rand_seed(OS.get_ticks_msec())[0] % num_levels # seed level generation with time
	level_index *= sign(level_index) # make sure the index is positive
	
	# load a random level and instance it
	var level_path = "res://level_templates/Template" + String(level_index) + ".tscn"
	var level = load(level_path).instance()
	
	# create the level
	active_levels.append(level)
	level.set_position(position)
	call_deferred("add_child", level)
