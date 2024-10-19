class_name PlayerMovementController
extends Node

var speed_init: float = 400.0
var speed_max: float = 800.0
var speed_current: float = speed_init
var acceleration: float = 20.0

var direction: Vector2

var actor: Player


func _ready() -> void:
	_initialize_controller()


func _process(delta: float) -> void:
	_player_movment()


func _initialize_controller() -> void:
	## Get owner/actor
	await get_owner().ready
	actor = get_owner()
	
	if actor == null: push_error("Unable to get player node!")


func _player_movment() -> void:
	actor.velocity = speed_current * direction
	actor.move_and_slide()







## Smooth out movement and include acceleration
#func _accelerate(_target_dir: Vector2):
	#var acceleration: float = 20
	#var target_velocity: Vector2 = _target_dir * speed_max
	#var smoothing: float = 1 - exp(- acceleration * get_process_delta_time())
	#
	#velocity = velocity.lerp(target_velocity, smoothing)
#
#func _decelerate() -> void:
	#_accelerate(Vector2.ZERO)
