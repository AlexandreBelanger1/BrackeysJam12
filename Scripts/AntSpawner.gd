extends Node2D
@onready var spawn_timer = $SpawnTimer
@onready var spawn_timer_2 = $SpawnTimer2
@onready var spawn_timer_3 = $SpawnTimer3
@onready var spawn_timer_4 = $SpawnTimer4
@onready var spawn_timer_5 = $SpawnTimer5
@onready var spawn_timer_6 = $SpawnTimer6
@onready var spawn_timer_7 = $SpawnTimer7


@export var spawnRadius = 1800
@export var spawnAngleStart = 0.00
@export var spawnAngleRange = 2*PI#(5.00/6.00) * PI

var RNG = RandomNumberGenerator.new()
const ANT = preload("res://Scenes/ant.tscn")

func _ready():
	SignalBus.startWave.connect(startSpawner)
	SignalBus.endWave.connect(stopSpawner)

func startSpawner(difficulty:int):
	if difficulty == 1:
		spawn_timer.start()
		spawn_timer_2.start()
		spawn_timer_3.start()
	elif difficulty == 2:
		spawn_timer.start()
		spawn_timer_2.start()
		spawn_timer_3.start()
		spawn_timer_4.start()
	elif difficulty == 3:
		spawn_timer.start()
		spawn_timer_2.start()
		spawn_timer_3.start()
		spawn_timer_4.start()
		spawn_timer_5.start()
		spawn_timer_6.start()
	elif difficulty >= 4:
		spawn_timer.start()
		spawn_timer_2.start()
		spawn_timer_3.start()
		spawn_timer_4.start()
		spawn_timer_5.start()
		spawn_timer_6.start()
		spawn_timer_7.start()

func stopSpawner():
	spawn_timer.stop()
	spawn_timer_2.stop()
	spawn_timer_3.stop()
	spawn_timer_4.stop()
	spawn_timer_5.stop()
	spawn_timer_6.stop()
	spawn_timer_7.stop()

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
