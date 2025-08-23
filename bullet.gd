extends RigidBody2D

@export var alive_time = 1.0
@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_tree().create_timer(alive_time)
	timer.timeout.connect(queue_free)
	pass # Replace with function body.
