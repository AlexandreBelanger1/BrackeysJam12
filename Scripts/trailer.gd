extends RigidBody2D
@onready var area_2d = $Area2D
@onready var sprite_2d = $Sprite2D
@onready var player = $"../Player"
@onready var upgrades_hitbox = $upgradesHitbox

const GRASS_PARTICLES = preload("res://Scenes/GrassParticles.tscn")

var unlocked = false

func _ready():
	SignalBus.upgradeUnlock.connect(upgrade)
	SignalBus.garageUI.connect(garageReset)
	SignalBus.hideTrailer.connect(hideTrailer)

func _on_area_2d_body_entered(body):
	var particles = GRASS_PARTICLES.instantiate()
	get_parent().add_child(particles)
	particles.global_position = body.global_position
	SignalBus.removePixel.emit(body.global_position.x,body.global_position.y)
	SignalBus.removeGrass.emit()
	body.queue_free()

func enable():
	unlocked = true
	visible = true
	area_2d.monitoring = true

func upgrade(index:int):
	if index == 5:
		area_2d.scale.x = 1.5
		upgrades_hitbox.scale.x = 1.5
		sprite_2d.scale.x = 1.5*sprite_2d.scale.x
	if index == 6:
		area_2d.scale.x = 2.5
		upgrades_hitbox.scale.x = 2.5
		sprite_2d.scale.x = 1.33*sprite_2d.scale.x
		sprite_2d.play("SuperTrailer")

func garageReset(enabled:bool):
	pass
	#rotation = -PI
	#global_position.y = player.getRearHitch().y - 60


func _on_upgrades_hitbox_body_entered(body):
	SignalBus.addPoints.emit(100)
	body.queue_free()

func hideTrailer(enabled:bool)->void:
	if enabled:
		visible = false
	elif unlocked:
		visible = true
		rotation = -PI
		global_position.y = player.getRearHitch().y - 60
