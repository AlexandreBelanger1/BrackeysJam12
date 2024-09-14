extends CharacterBody2D
const SPEED = 400
var direction = 0
var target = self

func _ready():
	set_physics_process(false)

func _on_area_2d_body_entered(body):
	target = body
	set_physics_process(true)


func _on_area_2d_body_exited(body):
	set_physics_process(false)
