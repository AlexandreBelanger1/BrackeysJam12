extends Node2D
@onready var top_left_marker = $TopLeftMarker
@onready var bottom_right_marker = $BottomRightMarker
@onready var house_sprite = $HouseSprite

var maxHP = 1000.00
var HP = 1000.00
var unitsBehindHouse = 0

func getCoordinates():
	return [top_left_marker.global_position.x, top_left_marker.global_position.y, bottom_right_marker.global_position.x, bottom_right_marker.global_position.y]


func _on_area_2d_body_entered(body):
	body.queue_free()
	takeDamage()


func takeDamage():
	HP = HP - 1
	SignalBus.houseDamage.emit(int(HP))
	if HP <= (0.80)* maxHP and HP > (0.60)*maxHP:
		house_sprite.frame = 1
	elif HP <= (0.60)* maxHP and HP > (0.40)*maxHP:
		house_sprite.frame = 2
	elif HP <= (0.40)* maxHP and HP > (0.20)*maxHP:
		house_sprite.frame = 3
	elif HP <= (0.20)* maxHP:
		house_sprite.frame = 4
	if HP <= 0.00:
		house_sprite.frame = 5
		house_sprite.modulate.a = 1
		SignalBus.loseGame.emit()




func _on_behind_house_body_entered(_body):
	unitsBehindHouse += 1
	house_sprite.modulate.a = 0.3


func _on_behind_house_body_exited(_body):
	unitsBehindHouse -= 1
	if unitsBehindHouse <= 0:
		house_sprite.modulate.a = 1
