extends Control
const MAP_PIXEL = preload("res://Scenes/map_pixel.tscn")
var mapArray = []
var grassSize = 32
@onready var background = $NewBackground
@onready var minimap_player_sprite = $MinimapPlayerSprite

#@onready var background = $Background
@onready var marker_2d = $Background/Marker2D


func _ready():
	SignalBus.removePixel.connect(remove)
	SignalBus.playerPosition.connect(updatePlayer)
	generateMap(80,80)


func generateMap(sizeX,sizeY):
	for i in sizeX:
		mapArray.append([])
		for j in sizeY:
			mapArray[i].append(0)
	for i in sizeX:
		for j in sizeY:
			
			var pixel = MAP_PIXEL.instantiate()
			background.add_child(pixel)
			pixel.global_position.x = marker_2d.global_position.x + (i*2)
			pixel.global_position.y = marker_2d.global_position.y + (j*2)
			mapArray[i][j] = pixel

func remove(posX:float,posY:float)->void:
	posX = posX/grassSize
	posY = posY/grassSize
	mapArray[posX][posY].queue_free()

func updatePlayer(pos:Vector2, rot:float):
	minimap_player_sprite.rotation = rot + (PI/2)
	minimap_player_sprite.global_position.x = marker_2d.global_position.x + (pos.x / 16)
	minimap_player_sprite.global_position.y = marker_2d.global_position.y + (pos.y / 16)
