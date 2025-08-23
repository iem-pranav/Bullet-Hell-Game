extends Node

var score = 0

@export var sfx_score: AudioStream = preload("res://Sounds/item_pickup.wav")  # Change the path to your music file
var music_player: AudioStreamPlayer  # Declare it here, but don't instantiate yet

func _ready() -> void:
	# Instantiate the music player
	music_player = AudioStreamPlayer.new()
	
	
func inc_score():
	score += 1
	# Add the music player to the scene tree
	get_tree().current_scene.add_child(music_player)
	music_player.stream = sfx_score
	music_player.volume_db = 10
	music_player.play()
