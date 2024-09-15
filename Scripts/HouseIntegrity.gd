extends Control

@onready var progress_bar = $ProgressBar
@onready var blink_timer = $BlinkTimer
var blinkDirection = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.houseDamage.connect(setValue)


func setValue(HP):
	if progress_bar.visible == false:
		progress_bar.visible = true
	progress_bar.value = HP
	if progress_bar.value <= (1/4) * progress_bar.max_value:
		blink_timer.start()


func _on_blink_timer_timeout():
	progress_bar.modulate.a += 0.1*blinkDirection
	if blinkDirection == -1 and progress_bar.modulate.a <= 0:
		blinkDirection = 1
	elif blinkDirection == 1 and progress_bar.modulate.a >= 1:
		blinkDirection = -1
