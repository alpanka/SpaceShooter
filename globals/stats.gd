extends Node

var window_size: Vector2
var window_x: int
var window_y: int
var window_margin: int = 50


func _ready() -> void:
	window_size = DisplayServer.window_get_size()
	window_x = int(window_size.x - window_margin)
	window_y = int(window_size.y - window_margin)
