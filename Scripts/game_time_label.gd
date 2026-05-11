extends Label

var game_over := false
var game_time := 100
var hasStarted = false
@onready var timer: Timer = $GameTimer
func _ready():
	timer.wait_time = game_time
	text = str(game_time)

func _on_game_timer_timeout() -> void:
	on_game_over()

func on_game_over():
	game_over = true
	var game := get_parent().get_parent() as Game
	if game == null:
		return
	for p in game.players:
		if p.is_it:
			text = "Player %d lost!" % (p.player_id + 1)
			return

func _process(_delta):
	if game_time <= 0:
		game_time = 50
	if game_time > 300:
		game_time = 300
	
	if get_parent().get_node("Menu").visible:
		visible = false
	
	
	if !get_parent().get_node("Menu").visible && timer.time_left == 0:
		timer.start()
		hasStarted = true
		visible = true
	if game_over:
		return
	text = str(snapped(timer.time_left, 1))
	if get_parent().get_node("Menu").get_child(1).menuVisible:
		if hasStarted == true && text == "0":
			hasStarted = false
			timer.stop()
