extends KinematicBody2D


var preseg = null
var maxsize = 20
var n = 0 
var velocity:Vector2
var accel_speed = 3
func _ready():
	var snakesegscene = load("res://Snake/SnakeSegment.tscn")
	if (n != 0):
		var seginst = snakesegscene.instance()
		seginst.preseg = self
		seginst.n = n-1
		scale.x = float(n)/maxsize
		scale.y = float(n)/maxsize
		seginst.position = position
		get_tree().get_root().call_deferred("add_child", seginst)
	else:
		scale.x = float(1)/maxsize
		scale.y = float(1)/maxsize
	modulate = lerp(modulate, Color.black, (maxsize-float(n))/maxsize)
	z_index = n-maxsize


func _physics_process(delta):
	if preseg != null: # only move if there is something to move to
		var dif_vector: Vector2 =  preseg.position - position
		# find the difference in position to where the segment should be
		if dif_vector.length() > (35 - 35*(maxsize-n)/maxsize): 
			# if it is too far away
			dif_vector = dif_vector - dif_vector.normalized()*(35 - 35*(maxsize-n)/maxsize)
			# move just the distance to get within the circle defined by the radius of (35 - 35*(maxsize-n)/maxsize)
			velocity += dif_vector.normalized() * accel_speed
			
			move_and_slide(20 * dif_vector)
			rotation = dif_vector.angle()
