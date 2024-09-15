extends CanvasLayer

const BULLET_PARTICLES = preload("res://Assets/Particles/bullet_particles.tres")
const GRASS_PARTICLES = preload("res://Assets/Particles/GrassParticles.tres")
const SMOKE_PARTICLES = preload("res://Assets/Particles/SmokeParticles.tres")

var materials = [SMOKE_PARTICLES,BULLET_PARTICLES,GRASS_PARTICLES ]
var loaded = false
var frames = 0


func _ready():
	for material in materials:
		var particles_instance = GPUParticles2D.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)

func _physics_process(_delta):
	if frames >= 3:
		loaded = true
		set_physics_process(false)
	frames += 1
