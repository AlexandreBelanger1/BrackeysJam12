extends CharacterBody2D

@onready var front = $Front
@onready var back = $Back

var speed = 800
var direction : Vector2

func _physics_process(delta):
	velocity = (front.global_position - back.global_position)
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_timer_timeout():
	queue_free()


func _on_hitbox_body_entered(body):
	body.queue_free()


func _on_lifetime_timeout():
	queue_free()
