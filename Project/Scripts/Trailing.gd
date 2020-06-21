extends Node2D
class_name Trailing

export var trail_speed : float
export var num_trails : int
export var pos_lerp : float

var target : Node2D
var child_trail : Node2D

export var target_path : NodePath

func reset():
	position = Vector2(0, 0)
	if(child_trail != null):
		child_trail.reset()

func _enter_tree():
	if(num_trails > 0):
		var new_trail = self.duplicate()
		new_trail.target_path = self.get_path()
		new_trail.trail_speed = trail_speed
		new_trail.num_trails = num_trails - 1
		new_trail.pos_lerp = pos_lerp
		new_trail.position = position
		child_trail = new_trail
		get_tree().root.call_deferred("add_child", new_trail)
	target = get_node(target_path)

func run(delta):
	position += (target.position - position) * pos_lerp * delta
