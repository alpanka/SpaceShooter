class_name PlayerMovementController
extends Node


var actor: Player

var speed_init: float = 400.0
var speed_max: float = 800.0
var speed_current: float = speed_init
var acceleration: float = 500.0
var smoothing: float

var limit_x_right: int		# Screen limit on right side
var limit_x_left: int		# Screen limit on left side
var in_screen: bool 		# BUG Not sure if we need this
var can_move: bool

var direction: Vector2


func _ready() -> void:
	_initialize_controller()


func _process(delta: float) -> void:
	_player_movement(delta)


func _initialize_controller() -> void:
	## Get owner/actor
	await get_owner().ready
	actor = get_owner()
	
	if actor == null: push_error("Unable to get player node!")
	
	# Get the size of active viewport.
	# As aspect is "keep", this means that it'll be a fixed width.
	# If aspect was not "keep", this would have been changing as window is resized.
	limit_x_right = int(get_viewport().get_visible_rect().size.x)
	limit_x_left = 10
	
	in_screen = true
	can_move = true


func _player_movement(delta) -> void:
	if can_move:
		smoothing = 1 - exp(-1 * acceleration * delta)
		actor.velocity = actor.velocity.lerp(speed_current * direction, smoothing)
		actor.move_and_slide()
	if _check_player_pos_limit() != Vector2.ZERO:
		can_move = false
		in_screen = false
		_bounce_back_to_limit()


## Check if player is trying to leave the screen
## Return a vector in the opposite direction
func _check_player_pos_limit() -> Vector2:
	## Player pushed through left
	if actor.global_position.x <= limit_x_left:
		return Vector2.RIGHT
	## Player pushed through right
	if actor.global_position.x >= limit_x_right:
		return Vector2.LEFT
	else:
		return Vector2.ZERO


## Push player ship back to mid-screen.
func _bounce_back_to_limit():
	if can_move and in_screen:
		return
	
	var target_dir: Vector2 = _check_player_pos_limit()
	var bounce_distance: float = 50 * target_dir.x
	var current_pos: Vector2 = actor.global_position
	var target_pos: Vector2 = current_pos + Vector2(bounce_distance, 0)
	
	var tween: Tween = create_tween()
	tween.tween_property(actor, "global_position", target_pos, 0.2).\
	set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	# TODO consider adjusting the easing?
	
	in_screen = true
	await get_tree().create_timer(0.5).timeout
	can_move = true
	# TODO Add a shake anim until you can move?


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
