extends CharacterBody2D
@onready var collider = $CollisionPolygon2D
@onready var shoot_timer = $ShootTimer
@onready var marker_2d = $Marker2D
const BULLET = preload("res://Scenes/bullet.tscn")
var pointX
var pointY
var RNG = RandomNumberGenerator.new()

func _input(event)->void:
	#Vacuum Mode
	if Global.vacuumState == true:
		if event.is_action_pressed("LMB"):
			collider.disabled = false
	#Shoot Mode
	if Global.vacuumState == false:
		if event.is_action_pressed("LMB"):
			shoot_timer.start()
	#Disable Vacuum/Shoot
	if event.is_action_released("LMB"):
		collider.disabled = true
		shoot_timer.stop()
		Global.shooting = false

func _physics_process(delta)->void:
	pointX = get_global_mouse_position().x - global_position.x
	pointY = get_global_mouse_position().y - global_position.y
	if pointX > 0 :
		rotation = (atan(pointY/pointX)) 
	else:
		rotation = (PI+ atan(pointY/pointX))




func _on_shoot_timer_timeout()->void:
	if Global.score >= 1:
		SignalBus.addPoints.emit(-1)
		shoot()
		Global.shooting = true
	else:
		Global.shooting = false


func shoot()->void:
	var randOffset = RNG.randf_range(-10,10)
	var projectile = BULLET.instantiate()
	get_parent().get_parent().add_child(projectile)
	projectile.global_position = marker_2d.global_position
	projectile.velocity.x = pointX +randOffset
	projectile.velocity.y = pointY +randOffset
	if(projectile.velocity.x >0):
		projectile.rotate(atan( projectile.velocity.y/projectile.velocity.x)) 
	else:
		projectile.rotate(PI+ atan( projectile.velocity.y/projectile.velocity.x)) 
