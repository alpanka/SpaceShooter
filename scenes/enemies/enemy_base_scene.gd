class_name EnemyBaseScene
extends CharacterBody2D

## Timer nodes
@onready var idle_timer: Timer = $Modules/IdleTimer
@onready var attack_timer: Timer = $Modules/AttackTimer

## Stats resource
@export var stats: EnemyBaseResource

## Speed variables
var speed_init: float
var speed_max: float

## Health and damage
var damage_amount: int
var health_init: int


func _ready() -> void:
	_initialize_enemy_stats()


## Update variables based on its resource
func _initialize_enemy_stats() -> void:
	# Timers
	idle_timer.wait_time = stats.idle_time_duration
	attack_timer.wait_time = stats.attack_time_duration
	
	# Resource
	speed_init = stats.speed_init
	speed_max = stats.speed_max
	damage_amount = stats.damage_amount
	health_init = stats.health_init
