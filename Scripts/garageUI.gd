extends Control

@onready var color_rect = $ColorRect

@onready var speed_upgrade_frame = $ColorRect/SpeedUpgradeFrame
@onready var size_upgrade_frame = $ColorRect/SizeUpgradeFrame
@onready var accel_upgrade_frame = $ColorRect/AccelUpgradeFrame
@onready var turn_speed_upgrade_frame = $ColorRect/TurnSpeedUpgradeFrame
@onready var speed_label = $ColorRect/SpeedLabel
@onready var size_label = $ColorRect/SizeLabel
@onready var accel_label = $ColorRect/AccelLabel
@onready var turn_speed_label = $ColorRect/TurnSpeedLabel
@onready var speed_cost_label = $ColorRect/SpeedCostLabel
@onready var accel_cost_label = $ColorRect/AccelCostLabel
@onready var size_cost_label = $ColorRect/SizeCostLabel
@onready var turn_speed_cost_label = $ColorRect/TurnSpeedCostLabel
@onready var speed_button = $ColorRect/SpeedUpgradeFrame/SpeedButton
@onready var size_button = $ColorRect/SizeUpgradeFrame/SizeButton
@onready var accel_button = $ColorRect/AccelUpgradeFrame/AccelerateButton
@onready var turn_speed_button = $ColorRect/TurnSpeedUpgradeFrame/TurnSpeedButton
@onready var hover_sound = $HoverSound
@onready var pressed_sound = $PressedSound





var speedLabels = {1: "Faster", 2: "Schmoving", 3: "ZOOOOOM", 4: "MAX"}
var speedCosts = {1: 100, 2: 200, 3: 300, 4: 0}
var speedUpgradeIndex = {1: 1, 2: 2, 3: 3}
var sizeLabels = {1: "Trailer", 2: "Super-Mower", 3: "GigaTractor", 4: "MAX"}
var sizeCosts = {1: 100, 2: 200, 3: 300, 4: 0}
var sizeUpgradeIndex = {1: 4, 2: 5, 3: 6}
var accelLabels = {1: "Acceleration", 2: "Burning Rubber", 3: "0 -> 100", 4: "MAX"}
var accelCosts = {1: 100, 2: 200, 3: 300, 4: 0}
var accelUpgradeIndex = {1: 7, 2: 8, 3: 9}
var turnSpeedLabels = {1: "Better Turning", 2: "Quick Corners", 3: "On a dime", 4: "MAX"}
var turnSpeedCosts = {1: 100, 2: 200, 3: 300, 4: 0}
var turnSpeedUpgradeIndex = {1: 10, 2: 11, 3: 12}

var speedIndex = 1
var sizeIndex = 1
var accelIndex = 1
var turnSpeedIndex = 1

func _on_speed_button_pressed():
	if Global.score >= speedCosts[speedIndex]:
		pressed_sound.play()
		SignalBus.upgradeUnlock.emit(speedUpgradeIndex[speedIndex])
		SignalBus.addPoints.emit(-1*speedCosts[speedIndex])
		speedIndex = speedIndex + 1
		if speedIndex >= 4 :
			speed_button.disabled = true
		speed_upgrade_frame.frame = speedIndex-1
		speed_label.text = speedLabels[speedIndex]
		speed_cost_label.text = str(speedCosts[speedIndex])


func _on_size_button_pressed():
	if Global.score >= sizeCosts[sizeIndex]:
		pressed_sound.play()
		SignalBus.upgradeUnlock.emit(sizeUpgradeIndex[sizeIndex])
		SignalBus.addPoints.emit(-1*sizeCosts[sizeIndex])
		sizeIndex = sizeIndex + 1
		if sizeIndex >= 4 :
			size_button.disabled = true
		size_upgrade_frame.frame = sizeIndex-1
		size_label.text = sizeLabels[sizeIndex]
		size_cost_label.text = str(sizeCosts[sizeIndex])


func _on_accelerate_button_pressed():
	if Global.score >= accelCosts[accelIndex]:
		pressed_sound.play()
		SignalBus.upgradeUnlock.emit(accelUpgradeIndex[accelIndex])
		SignalBus.addPoints.emit(-1*accelCosts[accelIndex])
		accelIndex = accelIndex + 1
		if accelIndex >= 4 :
			accel_button.disabled = true
		accel_upgrade_frame.frame = accelIndex-1
		accel_label.text = accelLabels[accelIndex]
		accel_cost_label.text = str(accelCosts[accelIndex])


func _on_turn_speed_button_pressed():
	if Global.score >= turnSpeedCosts[turnSpeedIndex]:
		pressed_sound.play()
		SignalBus.upgradeUnlock.emit(turnSpeedUpgradeIndex[turnSpeedIndex])
		SignalBus.addPoints.emit(-1*turnSpeedCosts[turnSpeedIndex])
		turnSpeedIndex = turnSpeedIndex + 1
		if turnSpeedIndex >= 4 :
			turn_speed_button.disabled = true
		turn_speed_upgrade_frame.frame = turnSpeedIndex-1
		turn_speed_label.text = turnSpeedLabels[turnSpeedIndex]
		turn_speed_cost_label.text = str(turnSpeedCosts[turnSpeedIndex])


func _on_done_button_pressed():
	SignalBus.garageUI.emit(false)
	SignalBus.volume.emit(true)


func _on_speed_button_mouse_entered():
	hover_sound.play()


func _on_size_button_mouse_entered():
	hover_sound.play()


func _on_accelerate_button_mouse_entered():
	hover_sound.play()


func _on_turn_speed_button_mouse_entered():
	hover_sound.play()
