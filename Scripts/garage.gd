extends StaticBody2D
@onready var garage_interior = $GarageInterior

@onready var garage_sprite = $GarageSprite
@onready var door_hitbox = $DoorHitbox
@onready var top_left_marker = $TopLeftMarker
@onready var bottom_right_marker = $BottomRightMarker


func _on_area_2d_body_entered(body):
	SignalBus.garageUI.emit(true)




func _on_detect_player_body_entered(_body):
	garage_sprite.speed_scale = 1
	garage_sprite.play("BigOpen")


func _on_detect_player_body_exited(_body):
	garage_sprite.speed_scale = -1
	garage_sprite.play("BigOpen")


func _on_garage_sprite_animation_finished():
	if garage_sprite.frame == 7:
		door_hitbox.set_collision_layer_value(1,false)
	elif  garage_sprite.frame == 0:
		door_hitbox.set_collision_layer_value(1,true)

func getCoordinates():
	return [top_left_marker.global_position.x, top_left_marker.global_position.y, bottom_right_marker.global_position.x, bottom_right_marker.global_position.y]


func _on_player_enter_body_entered(_body):
	garage_interior.y_sort_enabled = false
	SignalBus.hideTrailer.emit(true)
	print_debug("entering")


func _on_player_enter_body_exited(_body):
	garage_interior.y_sort_enabled = true
	SignalBus.hideTrailer.emit(false)
