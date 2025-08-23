extends Node2D

@onready var score: Label = $CanvasLayer/score
@onready var restart: Button = $CanvasLayer/restart
@onready var menu: Button = $CanvasLayer/menu

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _process(delta: float) -> void:
	score.text = "Final Score : "+ str(Globals.score)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
