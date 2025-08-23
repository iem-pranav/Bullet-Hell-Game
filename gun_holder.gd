extends Node2D

@export var rotation_speed: float = 10.0

var bullet_speed: int = 100
var fire_rate: float = 0.5

var can_fire = true
var bullet_scene = preload("res://Scenes/bullet.tscn")  # Make sure to create a Bullet scene

@onready var shootPoint = get_node("./Sprite2D/ShootPoint")
@onready var sfx_fire: AudioStreamPlayer2D = $"../sfx_fire"

var weapons = [
	{
	"bullet_speed" : 750,
	"fire_rate" : 0.1,
	"gun_sprite": load("res://Assets/Desert Eagle Sheet.png")
	},
	{
	"bullet_speed" : 1000,
	"fire_rate" : 0.2,
	"gun_sprite": load("res://Assets/gun2.png")
	},
	{
	"bullet_speed" : 200,
	"fire_rate" : 0.5,
	"gun_sprite": load("res://Assets/gun3.png")
	}
]

var weapon_ctr = 0

func _ready():
	set_weapon()

func set_weapon():
	bullet_speed = weapons[weapon_ctr]['bullet_speed']
	fire_rate = weapons[weapon_ctr]['fire_rate']
	$Sprite2D.texture = weapons[weapon_ctr]['gun_sprite']

	print("Bullet speed: ", bullet_speed, "Fire Rate: ", fire_rate)
	pass

func _process(delta: float):
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.direction_to(mouse_pos).angle()
	rotation = lerp_angle(rotation, angle, rotation_speed * delta)
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()
		sfx_fire.play()

	# Weapon Switching
	if Input.is_action_just_pressed("weapon_index_up"):
		if weapon_ctr < len(weapons) - 1:
			weapon_ctr += 1
		else:
			weapon_ctr = 0
		set_weapon()
	if Input.is_action_just_pressed("weapon_index_down"):
		if weapon_ctr > 1:
			weapon_ctr -= 1
		else:
			weapon_ctr = len(weapons) - 1
		set_weapon()
	

func shoot():
	can_fire = false
	
	# Bullet instance
	var bullet = bullet_scene.instantiate()
	bullet.global_position = shootPoint.global_position
	bullet.rotation = rotation
	
	# Add force
	bullet.apply_impulse(Vector2(bullet_speed, 0).rotated(rotation))
	
	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
	
	# Use await for the fire rate timer
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true
