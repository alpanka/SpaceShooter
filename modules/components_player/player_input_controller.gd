class_name PlayerInputController
extends Node

@export var movement_controller: PlayerMovementController
@export var actor: Player


func _ready() -> void:
	_initialize_controller()


func _process(delta: float) -> void:
	_check_player_input()


## Initial setup
func _initialize_controller() -> void:
	## Get owner/actor
	actor = get_owner()
	
	if actor == null:
		push_warning("Unable to get player node!")
	


## Player input listener
func _check_player_input() -> void:
	## Check movement key press
	movement_controller.direction.x = Input.get_axis("ui_left", "ui_right")
	
	## Attack action
	if Input.is_action_just_pressed("ui_accept"):
		actor.launch_projectile()
	
