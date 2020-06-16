extends Node

var num_levels = 1

func _process(delta):
	if(Input.is_action_just_pressed("throw_ball")):
		create_level(Vector2(0, 0))

# create a random level at a given position
func create_level(position : Vector2):
	var level_index = randi() % num_levels
	
	# load a random level and instance it
	var level_path = "res://level_templates/Template" + String(level_index) + ".tscn"
	var level = load(level_path).instance()
	
	level.set_position(position)
	call_deferred("add_child", level)
	
