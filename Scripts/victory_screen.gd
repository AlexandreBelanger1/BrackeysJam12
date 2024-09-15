extends Control

@onready var replay_button = $ReplayButton
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2
@onready var fade_timer = $FadeTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.winGame.connect(startUp)


func _on_replay_button_pressed():
	Global.score = 0
	Global.totalGrass = 0
	Global.grassRemoved = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func startUp():
	animation_player.play("RunningAnts")
	animation_player_2.play("antsRunning")
	fade_timer.start()


func _on_fade_timer_timeout():
	modulate.a += 0.1
	if modulate.a >= 1:
		fade_timer.stop
