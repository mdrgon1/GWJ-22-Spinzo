extends Node2D

func _ready():
	var enemy_spawns = $EnemySpawns
	for child in enemy_spawns.get_children():
		create_enemy_at(child)
		child.call_deferred("queue_free")

func create_enemy_at(target : Node2D):
	print(target.global_position)
