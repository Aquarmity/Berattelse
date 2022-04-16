extends KinematicBody2D
class_name Monster

export var health = 10


func hurt():
	health -= 1
