extends TextureButton

var toggleC = 0
var blinkToggle = true
var animate = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_node("BlinkToggle").modulate.r)
	if blinkToggle == false:
		get_tree().current_scene.get_node("Player1").blink = false
		get_tree().current_scene.get_node("Player2").blink = false
		get_tree().current_scene.get_node("Player3").blink = false
		get_tree().current_scene.get_node("Player4").blink = false
	if blinkToggle == true:
		get_tree().current_scene.get_node("Player1").blink = true
		get_tree().current_scene.get_node("Player2").blink = true
		get_tree().current_scene.get_node("Player3").blink = true
		get_tree().current_scene.get_node("Player4").blink = true
		
	if(animate == 1 and get_node("BlinkToggle").position.x < 105):
		get_node("BlinkToggle").position.x += 1 * delta * 300
	elif(animate == -1 and get_node("BlinkToggle").position.x > 50):
		get_node("BlinkToggle").position.x -= 1 * delta * 300
	if(get_node("BlinkToggle").position.x >= 105):
		get_node("BlinkToggle").position.x = 105
		get_node("BlinkToggle").modulate.g = 100
		get_node("BlinkToggle").modulate.r = 0
	if(get_node("BlinkToggle").position.x <= 50):
		get_node("BlinkToggle").position.x = 50
		get_node("BlinkToggle").modulate.g = 0
		get_node("BlinkToggle").modulate.r = 100
func _on_pressed() -> void:
	toggleC += 1
	if toggleC % 2 == 0:
		blinkToggle = true
		animate = 1
	else:
		blinkToggle = false
		animate = -1
