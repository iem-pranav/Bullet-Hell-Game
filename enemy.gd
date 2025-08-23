extends CharacterBody2D

@export var speed = 50.0
@export var stop_at_distance = 40
@export var hit_effect: PackedScene

@onready var player = get_node("/root/Game/Player")
@onready var healthbar = $HealthBar

var health: int = 100

func _ready() -> void:
	healthbar.init_health(health)
	
func take_damage(damage):
	health -= damage
	#update healthbar health
	healthbar.health = health

	if health <= 0:
		Globals.inc_score() # Increment kill count in the global script
		die()

func die():
	queue_free()

func _physics_process(_delta):
	if not player: return

	if (player.global_position - global_position).length() < stop_at_distance:
		return
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("bullets"):
		take_damage(body.damage)
		
		# Hit Effect
		var hit_fx = hit_effect.instantiate()
		hit_fx.global_position = global_position
		get_tree().current_scene.add_child(hit_fx)

		print('Hit, Health Remaining: ', health)
		body.queue_free()
	pass
