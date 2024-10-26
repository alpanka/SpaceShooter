class_name Player
extends CharacterBody2D

@export var health_component: HealthComponent
@export var projectile: PackedScene = preload("res://scenes/projectiles/projectile_base_scene.tscn")

@onready var nozzle_left: Marker2D = $Nozzle/NozzleLeft
@onready var nozzle_center: Marker2D = $Nozzle/NozzleCenter
@onready var nozzle_right: Marker2D = $Nozzle/NozzleRight


var health_init: int = 100


func _ready() -> void:
	pass


## Initial setup
func _initialize_player() -> void:
	pass


## Launch attack
func launch_projectile() -> void:
	var projectile_instance: ProjectileBaseScene = projectile.instantiate()
	var projectile_layer = get_tree().get_root()
	projectile_instance.global_position = nozzle_center.global_position
	projectile_layer.add_child(projectile_instance)
