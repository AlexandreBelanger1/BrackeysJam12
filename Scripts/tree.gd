extends StaticBody2D

func _on_area_2d_body_entered(_body):
	modulate.a = 0.3


func _on_area_2d_body_exited(_body):
	modulate.a = 1
