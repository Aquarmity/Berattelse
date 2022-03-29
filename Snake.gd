extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	var spr = $AnimatedSprite
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		spr.frame = 2
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		spr.frame = 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		spr.frame = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		spr.frame = 3
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
