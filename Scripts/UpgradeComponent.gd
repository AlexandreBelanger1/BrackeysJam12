extends Node2D


func _on_area_2d_body_entered(body):
	SignalBus.addPoints.emit(100)
	queue_free()
