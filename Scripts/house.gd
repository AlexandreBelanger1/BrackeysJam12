extends Node2D
@onready var top_left_marker = $TopLeftMarker
@onready var bottom_right_marker = $BottomRightMarker
@onready var damage_timer = $DamageTimer
@onready var house_sprite = $HouseSprite

var maxHP = 1000
var HP = 1000
var damageMagnitude = 0
var unitsBehindHouse = 0
func getCoordinates():
	return [top_left_marker.global_position.x, top_left_marker.global_position.y, bottom_right_marker.global_position.x, bottom_right_marker.global_position.y]


func _on_area_2d_body_entered(body):
	body.latch()
	damageMagnitude = damageMagnitude + 1
	if damage_timer.is_stopped():
		damage_timer.start()


func _on_damage_timer_timeout():
	if damageMagnitude >= 1:
		takeDamage()

func takeDamage():
	HP = HP - damageMagnitude
	SignalBus.houseDamage.emit(HP)
	if HP <= (4/5)* maxHP and HP > (3/5)*maxHP:
		house_sprite.frame = 1
	elif HP <= (3/5)* maxHP and HP > (2/5)*maxHP:
		house_sprite.frame = 2
	elif HP <= (2/5)* maxHP and HP > (1/5)*maxHP:
		house_sprite.frame = 3
	elif HP <= (1/5)* maxHP:
		house_sprite.frame = 4
	if HP <= 0:
		SignalBus.loseGame.emit()


func _on_area_2d_body_exited(_body):
	damageMagnitude = damageMagnitude - 1


func _on_behind_house_body_entered(_body):
	unitsBehindHouse += 1
	house_sprite.modulate.a = 0.3


func _on_behind_house_body_exited(_body):
	unitsBehindHouse -= 1
	if unitsBehindHouse <= 0:
		house_sprite.modulate.a = 1
