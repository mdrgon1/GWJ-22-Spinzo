extends Node

const IN_FRAME_BUFFER = 0
const LEVEL_SPAWN_BOUNDS = Rect2(Vector2(-50, -10), Vector2(50, -80))
const SPAWN_THRESHOLD_X = 700

var num_levels = 3
var active_levels = []

onready var camera : Camera2D = $Camera2D

func _process(delta):

	print(active_levels.size())

	if(active_levels.size() == 0):
		create_level(camera.position - Vector2(0, 10))
	
	for i in range(active_levels.size()):
		var level = active_levels[i]
		
		# despawn levels
		var lower_bound = camera.position.y + ProjectSettings.get_setting("display/window/size/height") * camera.zoom.y + IN_FRAME_BUFFER
		var upper_bound = camera.position.y * 2 - lower_bound
		if(level.position.y > lower_bound):
			level.queue_free()
			active_levels.erase(level)
			break
		
		# create new levels if necessary
		if(level.following_levels.size() == 0 && level.position.y >= upper_bound && abs(level.position.x - camera.position.x) < SPAWN_THRESHOLD_X):
			var new_level_pos = Vector2(randf(), randf())
			new_level_pos.x *= LEVEL_SPAWN_BOUNDS.size.x
			new_level_pos.y *= LEVEL_SPAWN_BOUNDS.size.y
			new_level_pos += LEVEL_SPAWN_BOUNDS.position
			new_level_pos += level.position
			
			level.following_levels.append(create_level(new_level_pos))

# create a random level at a given position
func create_level(position : Vector2):
	randomize() #randomize num generator
	
	var level_index = randi() % num_levels
	level_index *= sign(level_index) # make sure the index is positive
	
	# load a random level and instance it
	var level_path = "res://level_templates/Template" + String(level_index) + ".tscn"
	var level = load(level_path).instance()
	
	# create the level
	active_levels.append(level)
	level.set_position(position)
	call_deferred("add_child", level)
	return level
