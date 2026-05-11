extends TextureButton

var dispCount = 0
var animation = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().get_node("SettingsPanel").hide()

func _on_pressed() -> void:
	dispCount += 1
	
	if dispCount % 2 == 0:
		get_parent().get_node("SettingsPanel").hide()
	else:
		get_parent().get_node("SettingsPanel").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(scale.x)
	if(is_hovered() and scale.x < 1.3 and rotation_degrees > -90):
		rotation -= 0.018 * delta * 300
		scale.x += 0.003 * delta * 300
		scale.y += 0.003 * delta * 300
	elif(is_hovered() == false and scale.x > 1 and rotation_degrees < 0):
		rotation += 0.018 * delta * 300
		scale.x -= 0.003 * delta * 300
		scale.y -= 0.003 * delta * 300
