extends Label

var gameTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	gameTime = get_tree().current_scene.get_node("GameTimeLabel").game_time
	text = str(gameTime)
