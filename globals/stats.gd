extends Node

## Window size properties
var window_size: Vector2
var window_x: int
var window_y: int
var window_margin: int = 50

## Player stats
var player_health: int


func _ready() -> void:
	## Set window size properties
	window_size = DisplayServer.window_get_size()
	window_x = int(window_size.x - window_margin)
	window_y = int(window_size.y - window_margin)
