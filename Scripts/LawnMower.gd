extends CharacterBody2D

@onready var front_bumper = $FrontBumper
@onready var rear_bumper = $RearBumper
@onready var sprite_2d = $Sprite2D
@onready var hitbox = $Hitbox
@onready var mower_size = $CollectionHitbox/MowerSize
@onready var engine_sounds = $EngineSounds

var engineTopSpeedPitch = 1.5
var engineTopTurningSpeedPitch = 0.5
var turningTopSpeed = 4000.00
var topSpeed = 7000.00
var speed = 0.00
var turnSpeed = 0.60
var direction = Vector2(1,0)
var acceleration = 0.20
var t
var leftTurning = false
var rightTurning = false
var accelerating = true
var stormText = false

func _ready():
	SignalBus.upgradeUnlock.connect(upgrade)
	SignalBus.garageUI.connect(garageReset)

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
		scale = scale * 2
		sprite_2d.play("SuperTractor")
	if index == 10:
		turnSpeed = turnSpeed + 0.3
		turningTopSpeed = 5000.00
		engineTopTurningSpeedPitch += 0.3
	if index == 1:
		topSpeed = 9000.00
		engineTopSpeedPitch += 0.3
	if index == 2:
		topSpeed = 11000.00
		engineTopSpeedPitch += 1.0
	if index == 3:
		topSpeed = 18100.00
		engineTopSpeedPitch += 3.0
	if index == 7:
		acceleration = 0.40
	if index == 11:
		turnSpeed = turnSpeed +0.5
		turningTopSpeed = 6500.00
		engineTopTurningSpeedPitch += 1
	if index == 12:
		turnSpeed = turnSpeed +0.5
		turningTopSpeed = 8500.00
		engineTopTurningSpeedPitch += 1
	if index == 8:
		acceleration = 0.8
	if index == 9:
		acceleration = 1.1

func garageReset(enabled:bool):
	if !enabled:
		rotation = PI/2

func _on_upgrades_hitbox_body_entered(body):
	SignalBus.addPoints.emit(100)
	body.queue_free()

func getRearHitch():
	return rear_bumper.global_position
