extends KinematicBody2D

export (int) var speed = 150
export (int) var roll_speed = 250
var velocity = Vector2()

enum state{idle, fighting, rolling, running, under_attack}
var Time: float = 0.0

var player_state = state.running

var last_direction = Vector2(0,0)


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
		if velocity != Vector2.ZERO:
			last_direction = velocity
		var running_velocity = velocity.normalized() * speed
		if velocity != Vector2.ZERO:
			set_run_anim(last_direction)
		else:
			set_stand_anim(last_direction)
		move_and_slide(running_velocity)
		
		# any change state instructions
		if Input.is_action_just_pressed("ui_accept"):
			player_state = state.rolling
			
			var timer = Timer.new()
			timer.connect("timeout",self, "_on_Timer_timeout", [timer])
			add_child(timer)
			timer.start(0.2)

	if player_state == state.rolling:
		var fast_velocity = velocity * roll_speed
		move_and_slide(fast_velocity)
		
func _on_Timer_timeout(args):
	player_state = state.running
	var timer_to_be_destroyed = args
	timer_to_be_destroyed.queue_free()

func set_run_anim(dir:Vector2):
	if (dir.x > 0):
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	if (dir.y >= 0):
		$AnimatedSprite.play("rundown")
	else:
		$AnimatedSprite.play("runup")

func set_stand_anim(dir:Vector2):
	if (dir.x > 0):
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	if (dir.y >= 0):
		$AnimatedSprite.play("default")
	else:
		$AnimatedSprite.play("defaultup")
