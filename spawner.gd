extends Node2D

@export var enemy_scene: PackedScene

@export var min_time = 3
@export var max_time = 10
@export var delta = 2e-3

@onready var timer = $Timer

func _on_timer_timeout() -> void:

	timer.wait_time = randf_range(min_time, max_time)
	max_time -= delta

	var ene = enemy_scene.instantiate()
	ene.position = position
	get_tree().current_scene.add_child(ene)
