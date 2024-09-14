extends GPUParticles2D

@onready var player = $"../Player"

func _process(delta):
	global_position = player.global_position
