extends Control
@onready var volume_slide = $VolumeSlide



func _on_volume_slide_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))
