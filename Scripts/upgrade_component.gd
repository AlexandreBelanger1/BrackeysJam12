extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D

func obtain():
	set_collision_layer_value(7,false)
	animation_player.play("gainGear")
