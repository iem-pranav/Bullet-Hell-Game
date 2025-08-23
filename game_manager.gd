extends Node2D

@onready var score: Label = $CanvasLayer/score

	
func _process(delta: float) -> void:
	score.text = "SCORE : " + str(Globals.score)
