extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2()
export (int) var speed = 10000

func movement():
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y += 1
	if Input.is_action_pressed("ui_down"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	velocity = velocity.normalized() * speed
# Called when the node enters the scene tree for the first time.
func process(delta):
	movement()
	
	velocity = move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
