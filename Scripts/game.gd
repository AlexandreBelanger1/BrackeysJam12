extends Node2D
@onready var grass_group = $GrassGroup
@onready var trailer = $Trailer
@onready var house = $House
@onready var garage = $Garage

var grassSize = 32
var mapSize
var mapArray
var RNG = RandomNumberGenerator.new()
const UPGRADE_COMPONENT = preload("res://Scenes/upgrade_component.tscn")
const GRASS = preload("res://Scenes/grass.tscn")
func _ready():
	SignalBus.garageUI.connect(garageEnabled)
	generateGrass(Vector2(80,80))
	generateUpgrades()
	SignalBus.upgradeUnlock.connect(enableTrailer)
	SignalBus.volume.emit(false)
	SignalBus.dialogueText.emit("Welcome to your new home!")
	SignalBus.dialogueText.emit("The yard hasn't been mowed in years. Luckily, the previous tennants left a mower behind!")
	SignalBus.dialogueText.emit("Here are some instructions on how to use the mower:")
	SignalBus.dialogueText.emit("Use the A and D keys to steer the mower left and right.")
	SignalBus.dialogueText.emit("The mower will always move forward.")
	SignalBus.dialogueText.emit("Upgrade your mower in the garage with parts that you find.")
	SignalBus.dialogueText.emit("Relax, have a beer, and enjoy mowing the lawn.")
	
	
	SignalBus.halfway.connect(enableStorm)
	
	

func garageEnabled(enabled:bool):
	if enabled:
		get_tree().paused = true
	else:
		get_tree().paused = false

func generateGrass(size:Vector2):
	var houseCoorinates = house.getCoordinates()
	var garageCoorinates  = garage.getCoordinates()
	var grassCount = 0
	for i in size.x:
		for j  in size.y:
			var notInHouse = false
			var notInGarage = false
			if i*grassSize > houseCoorinates[0] and i*grassSize < houseCoorinates[2]:
				if j*grassSize > houseCoorinates[1] and j*grassSize < houseCoorinates[3]:
					pass
				else:
					notInHouse = true
			else:
				notInHouse = true
			if i*grassSize > garageCoorinates[0] and i*grassSize < garageCoorinates[2]:
				if j*grassSize > garageCoorinates[1] and j*grassSize < garageCoorinates[3]:
					pass
				else:
					notInGarage = true
			else:
				notInGarage = true
			
			if notInGarage and notInHouse:
				grassCount = grassCount + 1
				var grass = GRASS.instantiate()
				grass_group.add_child(grass)
				grass.global_position = Vector2(i*grassSize,j*grassSize)
	SignalBus.setupGameProgress.emit(grassCount)
	


func generateUpgrades():
	var grassAmount = grass_group.get_child_count()
	var selectedGrassList = []
	while selectedGrassList.size() < 50:
		var randINT = int(RNG.randf_range(0,grassAmount))
		if !selectedGrassList.has(randINT):
			selectedGrassList.append(randINT)
	
	for i in selectedGrassList:
		var gear = UPGRADE_COMPONENT.instantiate()
		add_child(gear)
		gear.global_position = grass_group.get_children()[i].global_position
	


func enableTrailer(value:int)->void:
	if value == 4:
		trailer.enable()

func enableStorm():
	SignalBus.volume.emit(false)
	SignalBus.dialogueText.emit("EMERGENCY ALERT: A WAVE OF GIANT, NUCLEAR ANTS ARE INVADING THE AREA.")
	SignalBus.dialogueText.emit("THEY APPEAR TO BE HEADING TOWARDS YOUR NEW HOUSE.")
	SignalBus.dialogueText.emit("RUN THE ANTS OVER AND SHOOT THEM DOWN BEFORE THEY DESTROY IT!")
	SignalBus.dialogueText.emit("USE THE CANNONS BUILT INTO YOUR TRACTOR USING 'SPACEBAR' (press and hold).")
	SignalBus.dialogueText.emit("THE ONLY WAY TO STOP THEM IS TO FINISH YOUR LAWN.")
	SignalBus.dialogueText.emit("BEST OF LUCK!")

