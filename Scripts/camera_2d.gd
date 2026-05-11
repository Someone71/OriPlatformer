extends Camera2D

var joinPanel
var highX
var lowX
var highY
var lowY
var zoomX
var zoomY
var posX
var posY
var initialDelay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	joinPanel = get_parent().get_node("Menu").get_child(4)
	initialDelay = 0
	zoom.x = 1.1
	zoom.y = 1.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	highX = 0
	highY = 0
	lowX = 2304
	lowY = -1292
	for player in joinPanel.joinedPlayers:
		if player.position.x > highX:
			highX = player.position.x
		elif player.position.x < lowX:
			lowX = player.position.x
		if player.position.y < highY:
			highY = player.position.y
		elif player.position.y > lowY:
			lowY = player.position.y
	
	posX = (lowX + highX)/2
	posY = (lowY + highY)/2
	
	position.x = move_toward(position.x, posX, 400 * delta)
	position.y = move_toward(position.y, posY, 400 * delta)
	
	zoom.x = move_toward(zoom.x, 1/(((highX - lowX))/(2302.0/2.0)), zoom.x/15 * delta)
	zoom.y = move_toward(zoom.y,  1/(((-highY) - (-lowY))/(1292.0/2.0)), zoom.y/15 * delta)
	
	
	if zoom.x > 1.3:
		zoom.x = 1.3	
	if zoom.x < 1.1:
		zoom.x = 1.1
	if zoom.y < 1.1:
		zoom.y = 1.1
	if zoom.y > 1.3:
		zoom.y = 1.3
	
	if zoom.x < zoom.y:
		zoom.y = zoom.x
	else:
		zoom.x = zoom.y
		
		

	
