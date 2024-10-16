extends CharacterBody2D


@export var projectile: PackedScene = preload("res://scenes/projectiles/projectile_base_scene.tscn")

@export var speed_init: float = 400.0
@export var speed_max: float = 800.0
@export var acceleration: float = 20.0

@onready var nozzle_left: Marker2D = $Nozzle/NozzleLeft
@onready var nozzle_center: Marker2D = $Nozzle/NozzleCenter
@onready var nozzle_right: Marker2D = $Nozzle/NozzleRight

var direction: Vector2


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	velocity = direction * speed_init
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		_launch_projectile()



func _launch_projectile() -> void:
	var projectile_instance: ProjectileBaseScene = projectile.instantiate()
	var projectile_layer = get_tree().get_root()
	projectile_instance.global_position = nozzle_center.global_position
	projectile_layer.add_child(projectile_instance)


# Smooth out movement and include acceleration
func _accelerate(_target_dir: Vector2):
	var target_velocity: Vector2 = _target_dir * speed_max
	var smoothing: float = 1 - exp(- acceleration * get_process_delta_time())
	
	velocity = velocity.lerp(target_velocity, smoothing)

func _decelerate() -> void:
	_accelerate(Vector2.ZERO)
