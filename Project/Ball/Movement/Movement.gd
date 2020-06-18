extends State

var velocity = Vector2(0, 0)

func run(_delta):
	velocity = owner.move_and_slide(velocity)

# slow down after hitting an enemy
func hit():
	velocity *= 0.2
	if(current_state == substates_map["Default"]):
		current_state.enter([])
	else:
		update_state("Default")
