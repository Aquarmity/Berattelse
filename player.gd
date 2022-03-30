extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

enum state{idle, fighting, rolling, running, underAttack}
var Time: float = 0.0

var player_state = state.idle


func _ready():
	get_input()


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta: float):
	get_input()
	if velocity.x != 0 or velocity.y != 0:
		player_state = state.running
		move_and_slide(velocity)
		if Input.is_action_pressed("ui_accept"):
			player_state = state.rolling
			velocity = velocity * 1.5
			move_and_slide(velocity)
	elif Input.is_action_pressed("ui_accept"):
		player_state = state.rolling
	else :
		player_state = state.idle
		velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	velocity = velocity * 1.5
	_physics_process(0.0)
	
