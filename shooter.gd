extends Node2D

@export var bullet_speed: int = 100
@export var fire_rate: float = 0.5

var can_fire = true
var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")  # Make sure to create a Bullet scene

@onready var player = get_node("/root/Game/Player")
@onready var sfx_shoot: AudioStreamPlayer2D = $sfx_shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not player: return
	var mouse_pos = player.global_position
	var angle = global_position.direction_to(mouse_pos).angle()
	rotation = lerp_angle(rotation, angle, 10 * delta)

	if can_fire:
		sfx_shoot.play()
		shoot()

func shoot():
	can_fire = false
	
	# Bullet instance
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.rotation = rotation
	
	# Add force
	bullet.apply_impulse(Vector2(bullet_speed, 0).rotated(rotation))
	
	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
	
	# Use await for the fire rate timer
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true
