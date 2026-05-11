extends TextureButton

var menuVisible = true
var taggerID

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	if get_parent().get_node("JoinPanel").playerCount >= 2:
		menuVisible = false
		get_tree().current_scene.get_node("GameTimeLabel").timer.wait_time = get_tree().current_scene.get_node("GameTimeLabel").game_time
		chooseTagger()
		get_parent().hide()

func chooseTagger():
	var players = get_parent().get_node("JoinPanel").joinedPlayers
	for player in players:
		player.is_it = false
		
	taggerID = randi() % players.size()
	players[taggerID].is_it = true
	
	for player in players:
		player.update_color()
	players[taggerID].tag_cooldown_timer = players[taggerID].tag_cooldown_time
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# game end
	if get_tree().current_scene.get_node("GameTimeLabel").hasStarted == true && get_tree().current_scene.get_node("GameTimeLabel").text == "0":
		menuVisible = true
		get_parent().show()
		
	
