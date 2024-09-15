extends Control

@onready var menu_theme = $MenuTheme
@onready var fade_timer = $FadeTimer
@onready var fade_background = $FadeBackground
@onready var fade_in_timer = $FadeInTimer

const GAME = preload("res://Scenes/game.tscn")

func _physics_process(_delta):
	if ParticlesCache.loaded:
		menu_theme.play()
		fade_timer.start()
		set_physics_process(false)



func _on_texture_button_pressed():
	get_tree().change_scene_to_packed(GAME)


func _on_fade_timer_timeout():
	fade_background.modulate.a  -= 0.1
	if fade_background.modulate.a <= 0:
		fade_timer.stop()
		fade_background.visible = false


func _on_play_button_pressed():
	fade_background.visible = true
	fade_in_timer.start()



func _on_fade_in_timer_timeout():
	if fade_timer.is_stopped():
		menu_theme.volume_db -= 8.00
		fade_background.modulate.a += 0.1
		if fade_background.modulate.a >= 1:
			get_tree().change_scene_to_packed(GAME)
