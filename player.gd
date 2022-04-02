extends KinematicBody2D

export (int) var speed = 200
export (int) var roll_speed = 500
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


func _physics_process(_delta):
	if player_state == state.running:
		# all the movement instructions for running
		get_input()
		var running_velocity = velocity.normalized() * speed
		move_and_slide(running_velocity)
		
		# any change state instructions
		if Input.is_action_just_pressed("ui_accept"):
			player_state = state.rolling
			
			var timer = Timer.new()
			timer.connect("timeout",self, "_on_Timer_timeout", [timer])
			add_child(timer)
			timer.wait_time = 0.1
			timer.start()
		if velocity == Vector2.ZERO:
			player_state = state.idle
	if player_state == state.rolling:
		var fast_velocity = velocity * roll_speed
		move_and_slide(fast_velocity)
	else: #any unknown state should just become idle
		get_input()
		if velocity != Vector2.ZERO:
			player_state = state.running
func _on_Timer_timeout(args):
	player_state = state.running
	var timer_to_be_destroyed = args
	timer_to_be_destroyed.queue_free()
	
