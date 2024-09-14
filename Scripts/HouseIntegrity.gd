extends Control

@onready var progress_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.houseDamage.connect(setValue)


func setValue(HP):
	if progress_bar.visible == false:
		progress_bar.visible = true
	progress_bar.value = HP
