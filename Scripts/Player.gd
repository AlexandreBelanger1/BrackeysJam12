extends CharacterBody2D

var direction = [0,0,0,0]
var speed = 10
var dodgeRoll = false
var time = 0
var dodgeTarget = Vector2(0,0)
var currentPosition = Vector2(0,0)

func _input(event):
	if event.is_action_pressed("up"):
		direction[0] = 1
	if event.is_action_pressed("down"):
		direction[1] = 1
	if event.is_action_pressed("left"):
		direction[2] = 1
	if event.is_action_pressed("right"):
		direction[3] = 1
	if event.is_action_released("up"):
		direction[0] = 0
	if event.is_action_released("down"):
		direction[1] = 0
	if event.is_action_released("left"):
		direction[2] = 0
	if event.is_action_released("right"):
		direction[3] = 0
	if event.is_action_pressed("switchVacuumMode"):
		Global.vacuumState = !Global.vacuumState
	if event.is_action_pressed("dodge"):
		time = 0
		currentPosition = global_position
		setDodgeTarget()
		dodgeRoll = true


func _physics_process(delta):
	if !dodgeRoll:
		global_position.x += (direction[3] - direction[2]) * speed
		global_position.y += (direction[1] - direction[0]) * speed
	else:
		time += delta * 5
		global_position = currentPosition.lerp(dodgeTarget,time)
		if global_position.is_equal_approx(dodgeTarget):
			dodgeRoll = false

func setDodgeTarget():
	dodgeTarget.x = global_position.x + 300*direction[3] - 300*direction[2]
	dodgeTarget.y = global_position.y + 300*direction[1] - 300*direction[0]

func _on_collection_hitbox_body_entered(body):
	SignalBus.addPoints.emit(1)
	body.queue_free()
