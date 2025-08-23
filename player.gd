extends CharacterBody2D

@export var speed = 200.0
@export var hit_effect: PackedScene

@onready var animated_sprite = $AnimatedSprite2D
@onready var healthbar = $CanvasLayer/HealthBar

#sound effects
@onready var sfx_hit: AudioStreamPlayer2D = $sfx_hit


var health = 100

func _ready() -> void:
	healthbar.init_health(health)

func _physics_process(delta):
	var input_x = Input.get_axis("move_left", "move_right")
	var input_y = Input.get_axis("move_up", "move_down")
	
	var direction = Vector2(input_x, input_y)
	
	if direction.length() > 0:
		direction = direction.normalized()
		
	# velocity = direction * speed
	
	move_and_collide(direction * speed * delta)
	
	#Animations
	if direction.x > 0:
		if direction.y > 0:
			animated_sprite.animation = "walk_down"
		elif direction.y < 0:
			animated_sprite.animation = "walk_up"
		else:
			animated_sprite.animation = "walk_left"
			animated_sprite.flip_h = true

	elif direction.x < 0:
		if direction.y > 0:
			animated_sprite.animation = "walk_down"
		elif direction.y < 0:
			animated_sprite.animation = "walk_up"
		else:
			animated_sprite.animation = "walk_left"
			animated_sprite.flip_h = false

	elif direction.y > 0:
		animated_sprite.animation = "walk_down"
	elif direction.y < 0:
		animated_sprite.animation = "walk_up"
	else:
		animated_sprite.animation = "idle_down"

func die():
	# TODO: Make death animation
	queue_free()
	
func gameOver():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_collisiondetector_body_entered(body:Node2D):
	# Body is enemies bullet
	if body.is_in_group("enemy_bullets"):
		health -= body.damage
		sfx_hit.play()
		
		if health >=0 :
			healthbar.health = health
		

		if health <= 0:
			$AnimationPlayer.play("death")
			return

		# Hit Effect
		var hit_fx = hit_effect.instantiate()
		hit_fx.global_position = global_position
		get_tree().current_scene.add_child(hit_fx)

		body.queue_free()
	pass

func _on_animation_player_animation_finished(anim_name:StringName):
	if anim_name == "death":
		die()
		gameOver()
	pass # Replace with function body.
	
	
