class_name HitboxComponent
extends Area2D

@export var auto_define_collision: bool = true

@onready var hitbox_area: CollisionShape2D = $HitboxArea

## Nodes and Resources
var actor: Node2D
var projectile_stats: ProjectileBaseResource

## Main variables
var damage_amount: int


func _ready() -> void:
	_initialize_hitbox_component()


## Initial setup
func _initialize_hitbox_component() -> void:
	## Get owner node -> damaging node2d
	await get_owner().ready
	actor = get_owner()
	
	## Check owner node
	if actor:
		projectile_stats = actor.projectile_stats
	else:
		push_error("Failed to pull ProjetileBaseResource!")
	
	## Pull resource variables
	damage_amount = projectile_stats.damage_amount
	
	## Set collision shape automatically
	_initialize_collision_area()


## Set Hitbox CollisionShape2D area based on owner's area
func _initialize_collision_area() -> void:
	## Do not set auto shape if disabled
	if auto_define_collision == false:
		return
	
	## Set color to red
	hitbox_area.debug_color = Color(1, 0, 0, 0.05)
	
	## Body's main CollisionShape2D
	var actor_collision_area: CollisionShape2D
	
	for child in actor.get_children():
		if child is CollisionShape2D:
			if child.name == "CollisionShape2D":
				actor_collision_area = child
	
	## Set shape and its position
	hitbox_area.shape = actor_collision_area.shape
	hitbox_area.global_position = actor_collision_area.global_position
	
