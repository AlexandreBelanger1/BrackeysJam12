extends Control

@onready var wave_progress_timer = $WaveProgressTimer
@onready var next_wave_timer = $NextWaveTimer

@onready var texture_progress_bar = $TextureProgressBar
@onready var label = $TextureProgressBar/Label

var waveCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.halfway.connect(beginWave)

func beginWave():
	texture_progress_bar.visible = true
	waveCount += 1
	label.text = "WAVE: " + str(waveCount)
	wave_progress_timer.start()
	SignalBus.startWave.emit(waveCount)

func _on_timer_timeout():
	texture_progress_bar.value -= 1
	if texture_progress_bar.value <=0:
		endWave()

func endWave():
	wave_progress_timer.stop()
	texture_progress_bar.visible = false
	SignalBus.endWave.emit()
	next_wave_timer.start()
	texture_progress_bar.value = texture_progress_bar.max_value


func _on_next_wave_timer_timeout():
	next_wave_timer.stop()
	beginWave()
