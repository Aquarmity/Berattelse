extends Monster

enum state{cactus, expand, blimp}

var blimp_state = state.cactus

export var speed = 100

func _physics_process(_delta):
	if blimp_state == state.blimp:
		$AnimatedSprite.play("rotate")
		var player = get_tree().get_nodes_in_group("player")[0]
		var dir = player.position-position
		move_and_slide(dir.normalized() * speed)
	if blimp_state == state.expand:
		if $AnimatedSprite.frame == 4:
			blimp_state = state.blimp
		$AnimatedSprite.play("expand")
	if blimp_state == state.cactus:
		$AnimatedSprite.play("default")





func _on_Area2D_body_entered(body):
	if blimp_state == state.cactus:
		if body != self:
			if body.is_in_group("player"):
				blimp_state = state.expand
