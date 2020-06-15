extends State

var velocity = Vector2(0, 0)

func run(_delta):
	velocity = owner.move_and_slide(velocity)
