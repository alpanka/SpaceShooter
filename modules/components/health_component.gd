class_name HealthComponent
extends Node

signal damage_received(health: int, damage: int)

@export var auto_define_collision: bool = true
@onready var hurtbox_area: CollisionShape2D = $HurtboxArea

var actor: CharacterBody2D
var health_init: int 		# initial health
var health_current: int		# current health


func _ready() -> void:
	_initialize_component()


## Initial setup
func _initialize_component() -> void:
	## Get owner node --> damage receiver
	await get_owner().ready
	actor = get_owner()
	
	## Set 
	if actor:
		health_init = actor.health_init
		health_current = health_init
	else:
		push_warning("Unable to get owner!")
	
	## Set hurtbox area automatically
	_initialize_collision_area()


## Set Hurtbox CollisionShape2D area based on owner's area
func _initialize_collision_area() -> void:
	## Do not set auto shape if disabled
	if auto_define_collision == false:
		return
	
	## Set color to green
	hurtbox_area.debug_color = Color(0, 1, 0, 0.05)
	
	## Body's main CollisionShape2D
	var actor_collision_area: CollisionShape2D
	
	for child in actor.get_children():
		if child is CollisionShape2D:
			if child.name == "CollisionShape2D":
				actor_collision_area = child
	
	## Set shape and its position
	hurtbox_area.shape = actor_collision_area.shape
	hurtbox_area.global_position = actor_collision_area.global_position


func take_damage(damage_amount: int) -> void:
	health_current = min(health_current - damage_amount, 0)
	damage_received.emit(health_current, damage_amount)
	
