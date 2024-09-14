extends Camera2D
@onready var player = $"../Player"

@export var randomStrength: float = 1
@export var shakeFade: float = 10
var RNG = RandomNumberGenerator.new()
var shakeStrength: float = 0.0
var shaking = false

func _ready():
	SignalBus.shoot.connect(shake)

func randomOffset():
	return Vector2((RNG.randf_range(-shakeStrength,shakeStrength)),RNG.randf_range(-shakeStrength,shakeStrength))

func _physics_process(delta):
	global_position = lerp(global_position, player.global_position, delta*5)
	
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0,shakeFade * delta)
		offset = randomOffset()

func shake():
	shakeStrength = randomStrength
