extends Node2D

const IN_FRAME_BUFFER = 0
const LEVEL_SPAWN_BOUNDS = Rect2(Vector2(-100, -50), Vector2(200, -150))
const DESPAWN_RECT = Rect2(Vector2(-150, -100), Vector2(150 * 2, 200))
const MIN_TIME_DILATION = 0.1
const TIME_DILATION_LERP = 0.4

var time_dilation = 1
var num_levels = 3
var active_levels = []
var grabbable_levels = []

onready var camera : Camera2D = $Camera2D

func _draw():
	var despawn_bounds = DESPAWN_RECT
	despawn_bounds.position += camera.position
	
	draw_rect(despawn_bounds, Color(1, 1, 1, 0.5))

func _process(delta):

	# deal with the time dilation when aiming
	if(Input.is_action_just_pressed("aim")):
		time_dilation = MIN_TIME_DILATION
	elif (!Input.is_action_pressed("aim")):
		time_dilation = 1
	else:
		time_dilation += (1 - time_dilation) * TIME_DILATION_LERP * delta
	
	print(time_dilation)

	# level generation, should be in it's own script but fuck it we ball
	if(active_levels.size() == 0):
		create_level(camera.position - Vector2(0, 10))
	
	if(active_levels.size() >= 2):
		pass
	
	var despawn_bounds = DESPAWN_RECT
	despawn_bounds.position += camera.position
	
	update()
	
	for i in range(active_levels.size()):
		var level = active_levels[i]
		var level_bounds = level.bounds_rect
		level_bounds.position += level.position
		
		# despawn levels
		if(!is_instance_valid(level)):
			active_levels.remove(i)
			break;
		if(!level_bounds.intersects(despawn_bounds)):
			if(level in get_tree().get_nodes_in_group("grabbable")):
				grabbable_levels.erase(level)
			level.queue_free()
			active_levels.erase(level)
			break
		
		# create new levels if necessary
		if(level.following_levels.size() == 0 && despawn_bounds.encloses(level_bounds)):
			for j in range((randi() % 2) + 1):
				var new_level_pos = Vector2(randf(), randf())
				new_level_pos.x *= LEVEL_SPAWN_BOUNDS.size.x
				new_level_pos.y *= LEVEL_SPAWN_BOUNDS.size.y
				new_level_pos += LEVEL_SPAWN_BOUNDS.position
				new_level_pos += level.position
				
				var new_level = create_level(new_level_pos)
				if(new_level != null):
					level.following_levels.append(new_level)
				else:
					j -= 1

# create a random level at a given position
func create_level(position : Vector2):
	randomize() #randomize num generator
	
	var level_index = randi() % num_levels
	level_index *= sign(level_index) # make sure the index is positive
	
	var level_path
	if(grabbable_levels.size() < 2):
		level_path = "res://level_templates/Grabbable.tscn"
	else:
		# load a random level and instance it
		level_path = "res://level_templates/Template" + String(level_index) + ".tscn"
	var level = load(level_path).instance()
	
	var level_bounds = level.bounds_rect
	level_bounds.position += position
	for other_level in active_levels:
		var other_level_bounds = other_level.bounds_rect
		other_level_bounds.position += other_level.position
		if(level_bounds.intersects(other_level_bounds)):
			level.queue_free()
			return
	
	# create the level
	active_levels.append(level)
	if(level_path == "res://level_templates/Grabbable.tscn"):
		grabbable_levels.append(level)
	level.set_position(position)
	call_deferred("add_child", level)
	return level
