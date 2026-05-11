extends Node2D

var starting_tagger: int = randi() % 4

var players

func _ready():
	players = [$Player1, $Player2, $Player3, $Player4]
