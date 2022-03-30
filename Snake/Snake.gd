extends KinematicBody2D

export (int) var accel_speed = 1
onready var player = null 
var velocity = Vector2()
var snakesegscene = preload("res://Snake/SnakeSegment.tscn")
var numberofsegments = 20
func _ready():
	var seginst = snakesegscene.instance()
	seginst.preseg = self
	seginst.n = numberofsegments-1
	seginst.position = position
	get_tree().get_root().call_deferred("add_child", seginst)
	if (get_tree().get_nodes_in_group("player")):
		player = get_tree().get_nodes_in_group("player")[0]

func get_input():
	var accel = 0
	if player == null: 
		velocity = Vector2()
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		#spr.frame = 2
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		#spr.frame = 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		#spr.frame = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		#spr.frame = 3
	else:
		accel = player.position-position
	velocity += accel.normalized() * accel_speed
	
	

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = velocity.bounce(collision.normal)
