extends Node2D
@onready var spawn_timer = $SpawnTimer

@export var spawnRadius = 4000
@export var spawnAngleStart = 0.00
@export var spawnAngleRange = (5.00/6.00) * PI

var RNG = RandomNumberGenerator.new()
const ANT = preload("res://Scenes/ant.tscn")

func _ready():
	SignalBus.halfway.connect(startSpawner)

func startSpawner():
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn()

func spawn():
	var ant = ANT.instantiate()
	get_parent().add_child(ant)
	randomizePosition(ant)

func randomizePosition(ant):
	var angle = RNG.randf_range(spawnAngleStart, spawnAngleStart + spawnAngleRange)
	var posX = global_position.x + spawnRadius * sin(angle)
	var posY = global_position.y + spawnRadius * cos(angle)
	ant.global_position = Vector2(posX,posY)
	ant.look_at(global_position)
