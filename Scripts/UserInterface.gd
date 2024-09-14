extends Control
@onready var score_label = $ScoreLabel
@onready var garage_player_ui = $garagePlayerUI
@onready var game_over_button = $GameOverButton

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.addPoints.connect(addScore)
	SignalBus.garageUI.connect(garageControl)
	SignalBus.loseGame.connect(loseGame)
	SignalBus.winGame.connect(winGame)


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

func _on_button_pressed():
	Global.score = 0
	Global.totalGrass = 0
	Global.grassRemoved = 0
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func winGame():
	get_tree().paused = true
	game_over_button.visible = true
