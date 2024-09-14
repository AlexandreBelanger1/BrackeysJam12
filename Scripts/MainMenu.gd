extends Control

const GAME = preload("res://Scenes/game.tscn")

func _on_texture_button_pressed():
	get_tree().change_scene_to_packed(GAME)
