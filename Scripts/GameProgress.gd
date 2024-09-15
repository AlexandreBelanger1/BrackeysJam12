extends Control

@onready var progress_bar = $ProgressBar
var halfwayFlag = false

func _ready():
	SignalBus.setupGameProgress.connect(setup)
	SignalBus.removeGrass.connect(removeGrass)

func setup(totalGrass:int):
	progress_bar.max_value = totalGrass
	progress_bar.value = totalGrass


func removeGrass():
	progress_bar.value = progress_bar.value - 1
	if progress_bar.value <= (progress_bar.max_value/2) and !halfwayFlag:
		SignalBus.halfway.emit()
		halfwayFlag = true
	
	if progress_bar.value <= 2:
		SignalBus.winGame.emit()
