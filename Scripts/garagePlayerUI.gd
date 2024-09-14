extends Control

var upgradeCostDict = {"bladeCost": -300, "turnCost": -100, "speedCost": -150,
 "accelCost": -200, "trailerCost": -400,"turnCost2": -300, "speedCost2": -250,
 "speedCost3": -500, "accelCost2": -200,"trailerCost2": -400}
@onready var blades_upgrade = $ColorRect/BladesUpgrade
@onready var turning_upgrade = $ColorRect/TurningUpgrade
@onready var speed_upgrade = $ColorRect/SpeedUpgrade
@onready var accel_upgrade = $ColorRect/AccelUpgrade
@onready var trailer_upgrade = $ColorRect/TrailerUpgrade
@onready var turning_upgrade_2 = $ColorRect/TurningUpgrade2
@onready var speed_upgrade_2 = $ColorRect/SpeedUpgrade2
@onready var speed_upgrade_3 = $ColorRect/SpeedUpgrade3
@onready var accel_upgrade_2 = $ColorRect/AccelUpgrade2
@onready var trailer_upgrade_2 = $ColorRect/TrailerUpgrade2





func _on_blades_upgrade_pressed():
	if Global.score >= -1 * upgradeCostDict["bladeCost"]:
		SignalBus.addPoints.emit(upgradeCostDict["bladeCost"])
		blades_upgrade.disabled = true
		trailer_upgrade.disabled = false
		SignalBus.upgradeUnlock.emit(1)


func _on_turning_upgrade_pressed():
	if Global.score >= -1 * upgradeCostDict["turnCost"]:
		SignalBus.addPoints.emit(upgradeCostDict["turnCost"])
		turning_upgrade.disabled = true
		turning_upgrade_2.disabled = false
		SignalBus.upgradeUnlock.emit(2)

func _on_speed_upgrade_pressed():
	if Global.score >= -1 * upgradeCostDict["speedCost"]:
		SignalBus.addPoints.emit(upgradeCostDict["speedCost"])
		speed_upgrade.disabled = true
		speed_upgrade_2.disabled = false
		SignalBus.upgradeUnlock.emit(3)

func _on_accel_upgrade_pressed():
	if Global.score >= -1 * upgradeCostDict["accelCost"]:
		SignalBus.addPoints.emit(upgradeCostDict["accelCost"])
		accel_upgrade.disabled = true
		accel_upgrade_2.disabled = false
		SignalBus.upgradeUnlock.emit(4)


func _on_done_button_pressed():
	SignalBus.garageUI.emit(false)


func _on_trailer_upgrade_pressed():
	if Global.score >= -1 * upgradeCostDict["trailerCost"]:
		SignalBus.addPoints.emit(upgradeCostDict["trailerCost"])
		trailer_upgrade.disabled = true
		trailer_upgrade_2.disabled = false
		SignalBus.upgradeUnlock.emit(5)


func _on_turning_upgrade_2_pressed():
	if Global.score >= -1 * upgradeCostDict["turnCost2"]:
		SignalBus.addPoints.emit(upgradeCostDict["turnCost2"])
		turning_upgrade_2.disabled = true
		SignalBus.upgradeUnlock.emit(6)


func _on_speed_upgrade_2_pressed():
	if Global.score >= -1 * upgradeCostDict["speedCost2"]:
		SignalBus.addPoints.emit(upgradeCostDict["speedCost2"])
		speed_upgrade_2.disabled = true
		speed_upgrade_3.disabled = false
		SignalBus.upgradeUnlock.emit(7)


func _on_speed_upgrade_3_pressed():
	if Global.score >= -1 * upgradeCostDict["speedCost3"]:
		SignalBus.addPoints.emit(upgradeCostDict["speedCost3"])
		speed_upgrade_3.disabled = true
		SignalBus.upgradeUnlock.emit(8)


func _on_accel_upgrade_2_pressed():
	if Global.score >= -1 * upgradeCostDict["accelCost2"]:
		SignalBus.addPoints.emit(upgradeCostDict["accelCost2"])
		accel_upgrade_2.disabled = true
		SignalBus.upgradeUnlock.emit(9)


func _on_trailer_upgrade_2_pressed():
	if Global.score >= -1 * upgradeCostDict["trailerCost2"]:
		SignalBus.addPoints.emit(upgradeCostDict["trailerCost2"])
		trailer_upgrade_2.disabled = true
		SignalBus.upgradeUnlock.emit(10)


func _on_turn_speed_button_pressed():
	pass # Replace with function body.


func _on_accelerate_button_pressed():
	pass # Replace with function body.


func _on_size_button_pressed():
	pass # Replace with function body.


func _on_speed_button_pressed():
	pass # Replace with function body.
