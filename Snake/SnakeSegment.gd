extends KinematicBody2D


var preseg = null
var maxsize = 20
var n = 0 

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
	if preseg != null:
		var difVector: Vector2 =  preseg.position - position
		if difVector.length() > (35 - 35*(maxsize-n)/maxsize): 
			difVector = difVector - difVector.normalized()*(35 - 35*(maxsize-n)/maxsize)
			move_and_collide(difVector)
			rotation = difVector.angle()
