extends Camera2D

onready var player = get_node("/root/TestWorld2/KinematicBody2D")


func _ready():
	#set_limit_smoothing_enabled(true)
	#set_limit(0, 0)
	#set_limit(1, 0)
	#set_limit(2, 1024)
	#set_limit(3, 600)
	pass
	
func _process (_delta):
	position.x = player.position.x
	position.y = player.position.y
