extends State

var velocity = Vector2(0, 0)

func run(_delta):
	if(Input.is_action_just_pressed("throw_ball")):
		owner.sound.set_stream(owner.charge)
		owner.sound.playing = true
	if(Input.is_action_just_released("throw_ball")):
		owner.sound.playing = false
	
	velocity = owner.move_and_slide(velocity)

# slow down after hitting an enemy
func hit():
	velocity *= 0.2
	if(current_state == substates_map["Default"]):
		current_state.enter([])
	else:
		update_state("Default")
