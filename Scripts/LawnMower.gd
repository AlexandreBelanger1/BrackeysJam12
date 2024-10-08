extends CharacterBody2D

@onready var front_bumper = $FrontBumper
@onready var rear_bumper = $RearBumper
@onready var sprite_2d = $Sprite2D
@onready var hitbox = $Hitbox
@onready var mower_size = $CollectionHitbox/MowerSize
@onready var engine_sounds = $EngineSounds
@onready var shoot_timer = $ShootTimer
@onready var shoot_marker_left = $ShootMarkerLeft
@onready var shoot_marker_right = $ShootMarkerRight
@onready var engine_start = $EngineStart



const BULLET = preload("res://Scenes/bullet.tscn")

var engineTopSpeedPitch = 1.5
var engineTopTurningSpeedPitch = 0.5
var turningTopSpeed = 4000.00
var topSpeed = 6000.00
var speed = 0.00
var turnSpeed = 0.60
var direction = Vector2(1,0)
var acceleration = 0.20
var t
var leftTurning = false
var rightTurning = false
var accelerating = true
var stormText = false
var gun = false
var shooting = false
var upgradedChassis = false

func _input(event):
	if event.is_action_pressed("shoot") and gun:
		shoot_timer.start()
	if event.is_action_released("shoot") and gun:
		shoot_timer.stop()


func _ready():
	SignalBus.upgradeUnlock.connect(upgrade)
	SignalBus.garageUI.connect(garageReset)
	SignalBus.halfway.connect(gunEnable)



func _physics_process(delta):
	direction = (front_bumper.global_position - rear_bumper.global_position).normalized()
	t = delta 
	if accelerating:
		speed = lerp(speed,topSpeed,acceleration*delta)
		engine_sounds.pitch_scale = lerp(engine_sounds.pitch_scale,engineTopSpeedPitch,acceleration*delta)
	
	if Input.is_action_just_pressed("left"):
		leftTurning = true
		accelerating = false
		if rightTurning:
			accelerating = true
	
	if Input.is_action_just_pressed("right"):
		rightTurning = true
		accelerating = false
		if leftTurning:
			accelerating = true
		
	if Input.is_action_just_released("left"):
		leftTurning = false
		if !rightTurning:
			accelerating = true
		else:
			accelerating = false
	
	if Input.is_action_just_released("right"):
		rightTurning = false
		if !leftTurning:
			accelerating = true
		else:
			accelerating = false
	if !accelerating:
		if Input.is_action_pressed("left"):
			if speed > turningTopSpeed:
				speed = lerp(speed,turningTopSpeed,t)
				engine_sounds.pitch_scale = lerp(engine_sounds.pitch_scale,engineTopTurningSpeedPitch,t)
			rotation = rotation - turnSpeed*delta
		if Input.is_action_pressed("right"):
			if speed > turningTopSpeed:
				speed= lerp(speed,turningTopSpeed,t)
				engine_sounds.pitch_scale = lerp(engine_sounds.pitch_scale,engineTopTurningSpeedPitch,t)
			rotation = rotation + turnSpeed*delta
	velocity = direction * speed * delta
	move_and_slide()

const GRASS_PARTICLES = preload("res://Scenes/GrassParticles.tscn")
func _on_collection_hitbox_body_entered(body):
	var particles = GRASS_PARTICLES.instantiate()
	get_parent().add_child(particles)
	particles.global_position = body.global_position
	SignalBus.removePixel.emit(body.global_position.x,body.global_position.y)
	SignalBus.removeGrass.emit()
	body.queue_free()

func upgrade(index: int)->void:
	if index ==  5:
		upgradedChassis = true
		scale = scale * 2
		sprite_2d.play("SuperTractor")
		if gun:
			sprite_2d.play("SuperTractorGun")
	if index == 10:
		turnSpeed = turnSpeed + 0.3
		turningTopSpeed = 5000.00
		engineTopTurningSpeedPitch += 0.3
	if index == 1:
		topSpeed = 9000.00
		engineTopSpeedPitch += 0.3
	if index == 2:
		topSpeed = 15000.00
		engineTopSpeedPitch += 1.0
	if index == 3:
		topSpeed = 30000.00
		engineTopSpeedPitch += 1.0
	if index == 7:
		acceleration = 0.40
	if index == 11:
		turnSpeed = turnSpeed +0.5
		turningTopSpeed = 6500.00
		engineTopTurningSpeedPitch += 1
	if index == 12:
		turnSpeed = turnSpeed +1.5
		turningTopSpeed = 11000.00
		engineTopTurningSpeedPitch += 1
	if index == 8:
		acceleration = 0.8
	if index == 9:
		acceleration = 2

func garageReset(enabled:bool):
	if !enabled:
		rotation = PI/2

func _on_upgrades_hitbox_body_entered(body):
	SignalBus.addPoints.emit(100)
	body.obtain()
	#body.queue_free()

func getRearHitch():
	return rear_bumper.global_position

func gunEnable():
	gun = true
	if !upgradedChassis:
		sprite_2d.play("decentTractorGun")
	else:
		sprite_2d.play("SuperTractorGun")


func _on_shoot_timer_timeout():
	var shotL = BULLET.instantiate()
	get_parent().add_child(shotL)
	shotL.global_position = shoot_marker_left.global_position
	shotL.rotation = rotation
	
	var shotR = BULLET.instantiate()
	get_parent().add_child(shotR)
	shotR.global_position = shoot_marker_right.global_position
	shotR.rotation = rotation
	SignalBus.shoot.emit()



func _on_minimap_update_timeout():
	SignalBus.playerPosition.emit(global_position,rotation)




func _on_engine_start_timeout():
	engine_sounds.play()
	engine_start.stop()
