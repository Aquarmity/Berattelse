extends Camera2D

onready var player = get_tree().get_nodes_in_group("player")[0]

export(Array, Vector2) var limit_points

func _ready():
	var bounds = get_tree().get_nodes_in_group("CameraBound")
	
	var minVector: Vector2 = bounds[0].position
	var maxVector: Vector2 = bounds[0].position
	
	for bound in bounds:
		bound = bound.position
		if bound.x < minVector.x:
			minVector.x = bound.x
		if bound.y < minVector.y:
			minVector.y = bound.y
		if bound.x > maxVector.x:
			maxVector.x = bound.x
		if bound.y > maxVector.y:
			maxVector.y = bound.y
	
	set_limit(MARGIN_LEFT, minVector.x)
	set_limit(MARGIN_RIGHT, maxVector.x)
	set_limit(MARGIN_BOTTOM, maxVector.y)
	set_limit(MARGIN_TOP, minVector.y)
func _process (_delta):
	position.x = player.position.x
	position.y = player.position.y
