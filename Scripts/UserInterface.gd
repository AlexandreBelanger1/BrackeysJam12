extends Control
@onready var score_label = $ScoreLabel
@onready var garage_player_ui = $garagePlayerUI
@onready var game_over_button = $GameOverButton
@onready var victory_screen = $"Victory Screen"
@onready var audio_stream_player = $AudioStreamPlayer
@onready var volume_slider = $VolumeSlider


var volumeDB = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	SignalBus.addPoints.connect(addScore)
	SignalBus.garageUI.connect(garageControl)
	SignalBus.loseGame.connect(loseGame)
	SignalBus.winGame.connect(winGame)
	SignalBus.volume.connect(volume)



func addScore(points:int)->void:
	Global.score += points
	score_label.text = str(Global.score)

func garageControl(enabled:bool):
	if enabled:
		garage_player_ui.visible = true
	else:
		garage_player_ui.visible = false
		get_tree().paused = false

func loseGame():
	get_tree().paused = true
	game_over_button.visible = true

func _physics_process(delta):
	audio_stream_player.volume_db = lerp(audio_stream_player.volume_db, volumeDB, delta)
	if is_equal_approx(audio_stream_player.volume_db,volumeDB):
		set_physics_process(false)

func winGame():
	get_tree().paused = true
	victory_screen.visible = true


func _on_game_over_button_pressed():
	Global.score = 0
	Global.totalGrass = 0
	Global.grassRemoved = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func volume(enabled:bool):
	if enabled:
		volumeDB = -8.0
		set_physics_process(true)
	else:
		volumeDB = -80.0
		set_physics_process(true)



func _on_volume_button_pressed():
	volume_slider.visible = !volume_slider.visible
