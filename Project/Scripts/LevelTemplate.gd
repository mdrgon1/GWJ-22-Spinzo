tool
extends Node2D

var num_hazards = 3
var following_levels = []

export var bounds_rect : Rect2

func _process(delta):
	
	# clean out deleted levels
	for i in range(following_levels.size()):
		if(is_instance_valid(following_levels[i])):
			following_levels.remove(i)
			break
	
	# draw bounds
	if(Engine.is_editor_hint()):
		update()


func _draw():
	if(Engine.is_editor_hint()):
		draw_rect(bounds_rect, Color(1, 1, 1, 0.5))

func _ready():
	
	if(!Engine.is_editor_hint()):
		var hazard_spawns = $EnemySpawns
		for child in hazard_spawns.get_children():
			create_enemy_at(child)

func create_enemy_at(target : Node2D):
	randomize()
	var hazard_index = randi() % (num_hazards + 1)
	hazard_index *= sign(hazard_index) # make sure the index is positive
	
	# theres a chance there will be no hazard
	if(hazard_index >= num_hazards):
		return
	
	# load a random hazard and instance it
	var hazard_path = "res://Hazards/Hazard" + String(hazard_index) + ".tscn"
	var hazard = load(hazard_path).instance()
	
	hazard.set_position(target.position)
	call_deferred("add_child", hazard)
	target.call_deferred("queue_free")
