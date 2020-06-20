extends Trailing

onready var sprite = $Sprite

func _ready():
	sprite.scale = target.sprite.scale
	sprite.offset = target.sprite.offset
	if(target in get_tree().get_nodes_in_group("player")):
		pos_lerp = 60

func _physics_process(delta):
	run(delta)

func _process(delta):
	if(sprite.animation != target.sprite.animation):
		sprite.play(target.sprite.animation)
	sprite.flip_h = target.sprite.flip_h
