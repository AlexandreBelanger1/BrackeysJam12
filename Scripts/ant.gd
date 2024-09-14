extends CharacterBody2D
@onready var front = $Front
@onready var back = $Back
@onready var sprite_2d = $Sprite2D

var speed = 5000
var direction
var turnSpeed = 0.2

func _physics_process(delta):
	direction = (front.global_position - back.global_position).normalized()
	if direction.x < 0:
		sprite_2d.flip_v = true
	else:
		sprite_2d.flip_v = false
	velocity = direction * speed * delta
	move_and_slide()

func _on_turning_timer_timeout():
	rotation = rotation + turnSpeed
	turnSpeed = -1 * turnSpeed

func latch():
	set_physics_process(false)


func _on_hitbox_body_entered(_body):
	queue_free()
