class_name ProjectileBaseScene
extends CharacterBody2D

@export var projectile_stats: ProjectileBaseResource

var speed: int
var damage_amount: int


func _ready() -> void:
	_initialize_projectile()


func _process(delta: float) -> void:
	move_and_collide(Vector2.UP * speed * delta)


func _initialize_projectile() -> void:
	# Connection to visibility signal
	$OnScreenNotifier.screen_exited.connect(_on_screen_exited)
	
	# Load resource variables
	speed = projectile_stats.speed
	damage_amount = projectile_stats.damage_amount


## Free once screen exited
func _on_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()
