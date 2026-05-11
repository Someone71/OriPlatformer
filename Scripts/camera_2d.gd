extends Camera2D

var game
var highX
var lowX
var highY
var lowY
var zoomX
var zoomY
var posX
var posY
@onready var tilemap: TileMapLayer = $"../TileMapLayer"
var world_bounds: Rect2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_parent()
	#world_bounds = get_tilemap_bounds()
#
#func get_tilemap_bounds() -> Rect2:
	#var used := tilemap.get_used_rect() # Rect2i in cells
#
	#var tile_set := tilemap.get_tile_set()
	#var cell_size: Vector2i = tile_set.tile_size
#
	## Local-space rect (pixels)
	#var local_rect := Rect2(
		#used.position * cell_size,
		#used.size * cell_size
	#)
#
	## Convert to global-space rect
	#var global_pos := tilemap.to_global(local_rect.position)
	#var global_end := tilemap.to_global(local_rect.position + local_rect.size)
#
	#return Rect2(global_pos, global_end - global_pos)
#
#func clamp_camera():
	#var half_w = get_viewport_rect().size.x * zoom.x / 2
	#var half_h = get_viewport_rect().size.y * zoom.y / 2
#
	#if world_bounds.size.x < half_w * 2:
		#position.x = world_bounds.position.x + world_bounds.size.x / 2
	#else:
		#position.x = clamp(
			#position.x,
			#world_bounds.position.x + half_w,
			#world_bounds.position.x + world_bounds.size.x - half_w
		#)
#
	#if world_bounds.size.y < half_h * 2:
		#position.y = world_bounds.position.y + world_bounds.size.y / 2
	#else:
		#position.y = clamp(
			#position.y,
			#world_bounds.position.y + half_h,
			#world_bounds.position.y + world_bounds.size.y - half_h
		#)
	#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game.players.is_empty():
		return
	
	lowX = game.players[0].position.x
	highX = game.players[0].position.x
	lowY = game.players[0].position.y
	highY = game.players[0].position.y
	
	for player in game.players:
		if player.position.x > highX:
			highX = player.position.x
		if player.position.x < lowX:
			lowX = player.position.x
		if player.position.y < highY:
			highY = player.position.y
		if player.position.y > lowY:
			lowY = player.position.y
	
	posX = (lowX + highX)/2
	posY = (lowY + highY)/2
	
	position.x = move_toward(position.x, posX, 400 * delta)
	position.y = move_toward(position.y, posY, 400 * delta)
	
	zoom.x = move_toward(zoom.x, 1/(((highX - lowX))/(2302.0/2.0)) - 0.4, zoom.x/7500)
	zoom.y = move_toward(zoom.y,  1/(((-highY) - (-lowY))/(1292.0/2.0)) - 0.4, zoom.y/7500)
	
	
	if zoom.x > 0.65:
		zoom.x = 0.65
	
	if zoom.x < 0.5:
		zoom.x = 0.5
	if zoom.y < 0.5:
		zoom.y = 0.5
	
	if zoom.x < zoom.y:
		zoom.y = zoom.x
	else:
		zoom.x = zoom.y
		
		

	
