class_name PlayerStatsUI
extends CanvasLayer


var player: Player


func _ready() -> void:
	_initialize_ui()


## Initial setup
func _initialize_ui() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	player.health_component.health_changed.connect(_on_health_changed)


func _on_health_changed(new_health: int) -> void:
	%HealthBar.value = new_health
