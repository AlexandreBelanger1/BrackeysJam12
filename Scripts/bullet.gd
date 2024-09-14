extends CharacterBody2D
var speed = 800

func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_timer_timeout():
	queue_free()
