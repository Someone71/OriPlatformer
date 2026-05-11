extends Control

var P1Joined = false
var P2Joined = false
var P3Joined = false
var P4Joined = false
var joinedPlayers = []

var playerCount = 0

var p1C = 0
var p2C = 0
var p3C = 0
var p4C = 0


var animate1 = 0;
var animate2 = 0;
var animate3 = 0;
var animate4 = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func join(id):
	if id == 0:
		if p1C % 2 == 0:
			playerCount -= 1
			joinedPlayers.erase(get_tree().current_scene.get_node("Player1"))
			P1Joined = false
		else:
			playerCount += 1
			joinedPlayers.append(get_tree().current_scene.get_node("Player1"))
			P1Joined = true
	if id == 1:
		if p2C % 2 == 0:
			playerCount -= 1
			joinedPlayers.erase(get_tree().current_scene.get_node("Player2"))
			P2Joined = false
		else:
			playerCount += 1
			joinedPlayers.append(get_tree().current_scene.get_node("Player2"))
			P2Joined = true
	if id == 2:
		if p3C % 2 == 0:
			playerCount -= 1
			joinedPlayers.erase(get_tree().current_scene.get_node("Player3"))
			P3Joined = false
		else:
			playerCount += 1
			joinedPlayers.append(get_tree().current_scene.get_node("Player3"))
			P3Joined = true
	if id == 3:
		if p4C % 2 == 0:
			playerCount -= 1
			joinedPlayers.erase(get_tree().current_scene.get_node("Player4"))
			P4Joined = false
		else:
			playerCount += 1
			joinedPlayers.append(get_tree().current_scene.get_node("Player4"))
			P4Joined = true
			
func animate(delta):
	if(animate1):
		if(P1Joined == true and get_node("P1Join/AngyBoy").scale.x < 3.5):
			get_node("P1Join/AngyBoy").visible = true
			get_node("P1Join/AngyBoy").scale.x += 0.1 * delta * 125
			get_node("P1Join/AngyBoy").scale.y += 0.1 * delta * 125
		elif(P1Joined == false and get_node("P1Join/AngyBoy").scale.x > 0.1):
			get_node("P1Join/AngyBoy").scale.x -= 0.1 * delta * 125
			get_node("P1Join/AngyBoy").scale.y -= 0.1 * delta * 125
			if(get_node("P1Join/AngyBoy").scale.x <= 0.1):
				get_node("P1Join/AngyBoy").visible = false
		else:
			animate1 = false
	if(animate2):
		if(P2Joined == true and get_node("P2Join/SadBoy").scale.x < 3.5):
			get_node("P2Join/SadBoy").visible = true
			get_node("P2Join/SadBoy").scale.x += 0.1 * delta * 125
			get_node("P2Join/SadBoy").scale.y += 0.1 * delta * 125
		elif(P2Joined == false and get_node("P2Join/SadBoy").scale.x > 0.1):
			get_node("P2Join/SadBoy").scale.x -= 0.1 * delta * 125
			get_node("P2Join/SadBoy").scale.y -= 0.1 * delta * 125
			if(get_node("P2Join/SadBoy").scale.x <= 0.1):
				get_node("P2Join/SadBoy").visible = false
		else:
			animate2 = false
	if(animate3):
		if(P3Joined == true and get_node("P3Join/XiaoBoy").scale.x < 3.5):
			get_node("P3Join/XiaoBoy").visible = true
			get_node("P3Join/XiaoBoy").scale.x += 0.1 * delta * 125
			get_node("P3Join/XiaoBoy").scale.y += 0.1 * delta * 125
		elif(P3Joined == false and get_node("P3Join/XiaoBoy").scale.x > 0.1):
			get_node("P3Join/XiaoBoy").scale.x -= 0.1 * delta * 125
			get_node("P3Join/XiaoBoy").scale.y -= 0.1 * delta * 125
			if(get_node("P3Join/XiaoBoy").scale.x <= 0.1):
				get_node("P3Join/XiaoBoy").visible = false
		else:
			animate3 = false
	if(animate4):
		if(P4Joined == true and get_node("P4Join/DefinitelyACyclopsBoy").scale.x < 3.5):
			get_node("P4Join/DefinitelyACyclopsBoy").visible = true
			get_node("P4Join/DefinitelyACyclopsBoy").scale.x += 0.1 * delta * 125
			get_node("P4Join/DefinitelyACyclopsBoy").scale.y += 0.1 * delta * 125
		elif(P4Joined == false and get_node("P4Join/DefinitelyACyclopsBoy").scale.x > 0.1):
			get_node("P4Join/DefinitelyACyclopsBoy").scale.x -= 0.1 * delta * 125
			get_node("P4Join/DefinitelyACyclopsBoy").scale.y -= 0.1 * delta * 125
			if(get_node("P4Join/DefinitelyACyclopsBoy").scale.x <= 0.1):
				get_node("P4Join/DefinitelyACyclopsBoy").visible = false
		else:
			animate4 = false
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().visible:
		if Input.is_action_just_pressed("upP1"):
			p1C += 1
			animate1 = true
			join(0)
		if Input.is_action_just_pressed("upP2"):
			p2C += 1
			animate2 = true
			join(1)
		if Input.is_action_just_pressed("jumpP3"):
			p3C += 1
			animate3 = true
			join(2)
		if Input.is_action_just_pressed("jumpP4"):
			p4C += 1
			animate4 = true
			join(3)
		animate(delta)
