extends Control
@onready var label = $ColorRect/RichTextLabel
@onready var color_rect = $ColorRect
@onready var audio = $AudioStreamPlayer2D


var textBuffer = ""
var index = 0
var nextReady = false
var timer = 0
var newDialogueBuffer = []
var running = false
var speed = 1

func _input(event):
	if event.is_action_pressed("LMB"):
		speed = 2
	if event.is_action_released("LMB"):
		speed = 1
	
	
	if nextReady and !event is InputEventMouseMotion:
		if newDialogueBuffer.size() !=  0:
			nextReady = false
			label.text = ""
			newDialogue(newDialogueBuffer.pop_front())
		else:
			running = false
			get_tree().paused = false
			color_rect.visible = false
			nextReady = false
			label.text = ""

func _ready():
	SignalBus.dialogueText.connect(start)
	set_process(false)

func start(text: String):
	if running:
		newDialogueBuffer.append(text)
	else:
		running = true
		get_tree().paused = true
		set_process(true)
		color_rect.visible = true
		textBuffer = text

func _process(delta):
	timer = timer+delta
	if timer > 0.01:
		addChar()
		audio.play()
		timer = 0

func addChar():
	label.text = label.text + textBuffer[index]
	index = index + 1
	if speed == 2 and index != textBuffer.length():
		label.text = label.text + textBuffer[index]
		index = index + 1
	if index == textBuffer.length():
		stop()

func stop():
	index = 0
	nextReady = true
	set_process(false)

func newDialogue(text:String):
	set_process(true)
	color_rect.visible = true
	textBuffer = text
