extends CharacterBody2D
#e
const SPEED = 400.0
const JUMP_VELOCITY = -800.0
var speedLimitY = 800
var negSpeedLimitY = -800
var speedLimitX = 800
var negSpeedLimitX = -800

var inAir = true
var animationSegment = 0
var blinking = false
var blinkAnimationSegment = 0

# Keybind variables
@export var up_action: String
@export var down_action: String
@export var left_action: String
@export var right_action: String
@export var jump_action: String
@export var dash_action: String
@export var power_action: String


# Tag variables
var is_it := false
@export var tag_cooldown_time := 3
var tag_cooldown_timer := 0.0 
@onready var cooldown_label: Label = get_node_or_null("CooldownLabel")
@export var player_id: int = 0 #
# 0 = Player1, 1 = Player2, 2 = Player3, 3 = Player4

# Dash variables
var dashSpeed = 900.0
var dashTime = 0.175
var isDashing = false
var dashTimer = 0.0
var dashDir = Vector2.ZERO
var dashCD = 0.0

var wallBounceSpeedTimer = 0.35
var waveDashChainTimer = 0
var waveDashChainCounter = 0
var isWaveDashing = false
var blinkCD = 0
var blinkAnimCD

# Wall jump/bounce speed variable
var prevX = 0

# Coyote time amount
var coyoteTime = 0.1
var wallBounceCoyoteTime = 0.15
var blink = false
var game; 
func _ready():
	powers()
	#game = get_parent()
	#if game:
		#is_it = (player_id == game.starting_tagger)
	#if is_it:
		#tag_cooldown_timer = tag_cooldown_time
	#else:
		#tag_cooldown_timer = 0.0
	#update_color()
  
func powers():
	if player_id == 0:
		blink = true 
	if player_id == 1:
		blink = true
	if player_id == 2:
		blink = true
	if player_id == 3:
		blink = true

func update_color():
	if is_it:
		if player_id == 0:
			get_node("RedNotIt").visible = false
			get_node("RedIt").visible = true
		if player_id == 1:
			get_node("BlueNotIt").visible = false
			get_node("BlueIt").visible = true
		if player_id == 2:
			get_node("GreenNotIt").visible = false
			get_node("GreenIt").visible = true
		if player_id == 3:
			get_node("YellowNotIt").visible = false
			get_node("YellowIt").visible = true
	else:
		if player_id == 0:
			get_node("RedNotIt").visible = true
			get_node("RedIt").visible = false
		if player_id == 1:
			get_node("BlueNotIt").visible = true
			get_node("BlueIt").visible = false
		if player_id == 2:
			get_node("GreenNotIt").visible = true
			get_node("GreenIt").visible = false
		if player_id == 3:
			get_node("YellowNotIt").visible = true
			get_node("YellowIt").visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_it and tag_cooldown_timer <= 0 and body is CharacterBody2D and body != self:
		is_it = false
		update_color()
		body.got_tagged()
		tag_cooldown_timer = tag_cooldown_time

func got_tagged():
	is_it = true
	tag_cooldown_timer = tag_cooldown_time
	update_color()

func dash():
	dashDir = Input.get_vector(left_action, right_action, up_action, down_action)
	dashDir = dashDir.normalized()
	isDashing = true
	dashCD = 1
	dashTimer = dashTime
	velocity = dashDir * dashSpeed * 0.75	
	if Input.is_action_pressed(up_action):
		velocity.y -= 200

func movement(delta):
	var direction := Input.get_axis(left_action, right_action)
	if direction:
		if velocity.x < 500 and velocity.x > -500:
			velocity.x += direction * 1200 * delta

func blinkEXE(delta):
	blinkCD -= delta
	
	if (!Input.is_action_just_pressed(power_action) and blinking == false):
		return
	blinking = true
	if(blinkAnimationSegment == 10 && blinkCD <= 0):
		var blinkDir = Input.get_vector(left_action, right_action, up_action, down_action)
		blinkDir = blinkDir.normalized()
		position += blinkDir * 150
		if position.x > 2250 || position.x < 50 || position.y > -50 || position.y < -1250:
			position -= blinkDir * 150
			blinkCD = 0
	elif(blinkAnimationSegment < 10 && blinkCD <= 0):
		#scale.x -= 0.075
		#scale.y -= 0.075
		if player_id == 0:
			get_node("RedNotIt").scale.x -= 0.096
			get_node("RedIt").scale.x -= 0.096
			get_node("RedNotIt").scale.y -= 0.096
			get_node("RedIt").scale.y -= 0.096
		if player_id == 1:
			get_node("BlueNotIt").scale.x -= 0.096
			get_node("BlueIt").scale.x -= 0.096
			get_node("BlueNotIt").scale.y -= 0.096
			get_node("BlueIt").scale.y -= 0.096
		if player_id == 2:
			get_node("GreenNotIt").scale.x -= 0.096
			get_node("GreenIt").scale.x -= 0.096
			get_node("GreenNotIt").scale.y -= 0.096
			get_node("GreenIt").scale.y -= 0.096
		if player_id == 3:
			get_node("YellowNotIt").scale.x -= 0.096
			get_node("YellowIt").scale.x -= 0.096
			get_node("YellowNotIt").scale.y -= 0.096
			get_node("YellowIt").scale.y -= 0.096
	elif(blinkAnimationSegment < 16 and blinkCD <= 0):
		#scale.x += 0.075
		#scale.y += 0.075
		if player_id == 0:
			get_node("RedNotIt").scale.x += 0.096
			get_node("RedIt").scale.x += 0.096
			get_node("RedNotIt").scale.y += 0.096
			get_node("RedIt").scale.y += 0.096
		if player_id == 1:
			get_node("BlueNotIt").scale.x += 0.096
			get_node("BlueIt").scale.x += 0.096
			get_node("BlueNotIt").scale.y += 0.096
			get_node("BlueIt").scale.y += 0.096
		if player_id == 2:
			get_node("GreenNotIt").scale.x += 0.096
			get_node("GreenIt").scale.x += 0.096
			get_node("GreenNotIt").scale.y += 0.096
			get_node("GreenIt").scale.y += 0.096
		if player_id == 3:
			get_node("YellowNotIt").scale.x += 0.096
			get_node("YellowIt").scale.x += 0.096
			get_node("YellowNotIt").scale.y += 0.096
			get_node("YellowIt").scale.y += 0.096
	else:
		if blinkCD <= 0:
			blinkCD = 10
		blinking = false
		blinkAnimationSegment = -1
	blinkAnimationSegment += 1
	

func jump():
	if Input.is_action_just_pressed(jump_action) and not isDashing and (is_on_floor() or coyoteTime > 0):
		velocity.y = JUMP_VELOCITY

func waveDash():
	if Input.is_action_just_pressed(jump_action) and is_on_floor():
		var direction := Input.get_axis(left_action, right_action)
		isWaveDashing = true
		waveDashChainTimer = 0.4525
		velocity.x = direction * dashSpeed * 2
		velocity.y = -500

func wallJump():
	var dashOffVal: float
	if velocity.x == 0 and prevX != 0:
		dashOffVal = -prevX
	if dashOffVal <= 200 and dashOffVal >= -200:
		if Input.is_action_pressed(left_action):
			dashOffVal = 400
		elif Input.is_action_pressed(right_action):
			dashOffVal = -400
	if Input.is_action_just_pressed(jump_action) and is_on_wall_only():
		velocity.y -= dashSpeed * 0.6
		velocity.x = dashOffVal
		
func wallBounce():
	var dashOffVal: float
	wallBounceSpeedTimer = 0.35
	if velocity.x == 0 and prevX != 0:
		dashOffVal = -prevX
	if dashOffVal <= 200 and dashOffVal >= -200:
		if Input.is_action_pressed(left_action):
			dashOffVal = 300
		elif Input.is_action_pressed(right_action):
			dashOffVal = -300
	if Input.is_action_pressed(up_action) and Input.is_action_just_pressed(jump_action) and (is_on_wall_only() or wallBounceCoyoteTime > 0):
		negSpeedLimitY = -1050
		velocity.y -= dashSpeed * 0.75
		velocity.x = dashOffVal

func speedFallOff(delta):
	var deltaSpeedX = velocity.x
	if is_on_floor():
		velocity.x -= deltaSpeedX * 3 * delta
	elif velocity.x < 200 and velocity.x > -200 and is_on_floor():
		velocity.x -= deltaSpeedX * 5 * delta
	else:
		velocity.x -= deltaSpeedX / 1.05 * delta

func animate():
	#print(animationSegment)
	#print(scale.x)
	#print(scale.y)
	if player_id == 0:
		if(is_on_floor()):
			if(inAir):
				animationSegment = 7
			if(animationSegment > 0 and get_node("RedNotIt").position.y < 2.31 and get_node("RedNotIt").scale.y > 0.771):
				get_node("RedNotIt").position.y += 0.33
				get_node("RedIt").position.y += 0.33
				get_node("RedNotIt").scale.y -= 0.027
				get_node("RedIt").scale.y -= 0.027
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = false
		else:
			if(inAir == false):
				animationSegment = 10
			if(animationSegment > 0 and get_node("RedNotIt").scale.x > 0.695):
				get_node("RedNotIt").scale.x -= 0.0265
				get_node("RedIt").scale.x -= 0.0265
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = true
			
		if(animationSegment == 0):
			if(get_node("RedNotIt").position.y > 0):
				get_node("RedNotIt").position.y -= 0.33
				get_node("RedIt").position.y -= 0.33
			if(get_node("RedNotIt").scale.y < 0.96):
				get_node("RedNotIt").scale.y += 0.027
				get_node("RedIt").scale.y += 0.027
			if(get_node("RedNotIt").scale.x < 0.96):
				get_node("RedNotIt").scale.x += 0.0265
				get_node("RedIt").scale.x += 0.0265
				
	if player_id == 1:
		if(is_on_floor()):
			if(inAir):
				animationSegment = 7
			if(animationSegment > 0 and get_node("BlueNotIt").position.y < 2.31 and get_node("BlueNotIt").scale.y > 0.771):
				get_node("BlueNotIt").position.y += 0.33
				get_node("BlueIt").position.y += 0.33
				get_node("BlueNotIt").scale.y -= 0.027
				get_node("BlueIt").scale.y -= 0.027
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = false
		else:
			if(inAir == false):
				animationSegment = 10
			if(animationSegment > 0 and get_node("BlueNotIt").scale.x > 0.695):
				get_node("BlueNotIt").scale.x -= 0.0265
				get_node("BlueIt").scale.x -= 0.0265
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = true
			
		if(animationSegment == 0):
			if(get_node("BlueNotIt").position.y > 0):
				get_node("BlueNotIt").position.y -= 0.33
				get_node("BlueIt").position.y -= 0.33
			if(get_node("BlueNotIt").scale.y < 0.96):
				get_node("BlueNotIt").scale.y += 0.027
				get_node("BlueIt").scale.y += 0.027
			if(get_node("BlueNotIt").scale.x < 0.96):
				get_node("BlueNotIt").scale.x += 0.0265
				get_node("BlueIt").scale.x += 0.0265
				
	if player_id == 2:
		if(is_on_floor()):
			if(inAir):
				animationSegment = 7
			if(animationSegment > 0 and get_node("GreenNotIt").position.y < 2.31 and get_node("GreenNotIt").scale.y > 0.771):
				get_node("GreenNotIt").position.y += 0.33
				get_node("GreenIt").position.y += 0.33
				get_node("GreenNotIt").scale.y -= 0.027
				get_node("GreenIt").scale.y -= 0.027
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = false
		else:
			if(inAir == false):
				animationSegment = 10
			if(animationSegment > 0 and get_node("GreenNotIt").scale.x > 0.695):
				get_node("GreenNotIt").scale.x -= 0.0265
				get_node("GreenIt").scale.x -= 0.0265
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = true
			
		if(animationSegment == 0):
			if(get_node("GreenNotIt").position.y > 0):
				get_node("GreenNotIt").position.y -= 0.33
				get_node("GreenIt").position.y -= 0.33
			if(get_node("GreenNotIt").scale.y < 0.96):
				get_node("GreenNotIt").scale.y += 0.027
				get_node("GreenIt").scale.y += 0.027
			if(get_node("GreenNotIt").scale.x < 0.96):
				get_node("GreenNotIt").scale.x += 0.0265
				get_node("GreenIt").scale.x += 0.0265
		
	if player_id == 3:
		if(is_on_floor()):
			if(inAir):
				animationSegment = 7
			if(animationSegment > 0 and get_node("YellowNotIt").position.y < 2.31 and get_node("YellowNotIt").scale.y > 0.771):
				get_node("YellowNotIt").position.y += 0.33
				get_node("YellowIt").position.y += 0.33
				get_node("YellowNotIt").scale.y -= 0.027
				get_node("YellowIt").scale.y -= 0.027
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = false
		else:
			if(inAir == false):
				animationSegment = 10
			if(animationSegment > 0 and get_node("YellowNotIt").scale.x > 0.695):
				get_node("YellowNotIt").scale.x -= 0.0265
				get_node("YellowIt").scale.x -= 0.0265
			if(animationSegment > 0):
				animationSegment -= 1
			inAir = true
			
		if(animationSegment == 0):
			if(get_node("YellowNotIt").position.y > 0):
				get_node("YellowNotIt").position.y -= 0.33
				get_node("YellowIt").position.y -= 0.33
			if(get_node("YellowNotIt").scale.y < 0.96):
				get_node("YellowNotIt").scale.y += 0.027
				get_node("YellowIt").scale.y += 0.027
			if(get_node("YellowNotIt").scale.x < 0.96):
				get_node("YellowNotIt").scale.x += 0.0265
				get_node("YellowIt").scale.x += 0.0265



func menuFunctionality():
	# Checks if Start has been pressed in Menu and if the time in the game is up.
	if !get_parent().get_node("Menu").visible:
		visible = true
	if get_parent().get_node("Menu").visible:
		visible = false

		if(player_id == 0):
			position.x = 268
			position.y = -1056
		if(player_id == 1):
			position.x = 2057
			position.y = -1219
		if(player_id == 2):
			position.x = 2057
			position.y = -70
		if(player_id == 3):
			position.x = 268
			position.y = -70
		velocity.x = 0
		velocity.y = 0
		blinkCD = 0
		return
	if get_parent().get_node("GameTimeLabel").hasStarted == true && get_parent().get_node("GameTimeLabel").text == "0":
		return
		
func checkPlayerIn():
	if player_id == 0 and get_parent().get_node("Menu").get_child(4).P1Joined != true:
		set_physics_process(false)
		position.x = -100
		position.y = -100
	if player_id == 1 and get_parent().get_node("Menu").get_child(4).P2Joined != true:
		set_physics_process(false)
		position.x = -100
		position.y = -100
	if player_id == 2 and get_parent().get_node("Menu").get_child(4).P3Joined != true:
		set_physics_process(false)
		position.x = -100
		position.y = -100
	if player_id == 3 and get_parent().get_node("Menu").get_child(4).P4Joined != true:
		set_physics_process(false)
		position.x = -100
		position.y = -100
	
	if player_id == 0 and get_parent().get_node("Menu").get_child(4).P1Joined == true:
		set_physics_process(true)
	if player_id == 1 and get_parent().get_node("Menu").get_child(4).P2Joined == true:
		set_physics_process(true)
	if player_id == 2 and get_parent().get_node("Menu").get_child(4).P3Joined == true:
		set_physics_process(true)
	if player_id == 3 and get_parent().get_node("Menu").get_child(4).P4Joined == true:
		set_physics_process(true)

func _process(_delta: float) -> void:
	checkPlayerIn()

func _physics_process(delta: float) -> void:
	menuFunctionality()
	
	
	# Functionality of the speed limits in any direction
	if velocity.x > speedLimitX:
		velocity.x = speedLimitX
	if velocity.x < negSpeedLimitX:
		velocity.x = negSpeedLimitX
	if velocity.y > speedLimitY:
		velocity.y = speedLimitY
	if velocity.y < negSpeedLimitY:
		velocity.y = negSpeedLimitY
	
	# Add the gravity.
	if not is_on_floor() and not blinking:
		velocity += get_gravity()*1.25 * delta*2
		coyoteTime -= delta
	
	if is_on_floor():
		coyoteTime = 0.1
	if is_on_wall_only():
		wallBounceCoyoteTime = 0.1
	if not is_on_wall_only():
		wallBounceCoyoteTime -= delta

	# Handle dash and the wallBounce timer
	dashCD -= delta
	wallBounceSpeedTimer -= delta
	waveDashChainTimer -= delta
	if Input.is_action_just_pressed(dash_action) and not isDashing and dashCD <= 0:
		dash()
	
	if blink:
		blinkEXE(delta)
	
	# Allows for wavedashing and adjusts movement speed while dashing
	if isDashing:
		waveDash()
		wallBounce()
	if not isDashing:
		wallJump()
	if is_on_floor():
		dashCD = 0
	dashTimer -= delta
	if dashTimer <= 0:
		isDashing = false
	
	# Allows wavedash chaining to be faster
	if waveDashChainTimer <= 0:
		isWaveDashing = false
		waveDashChainCounter = 0
		speedLimitX = 800
		negSpeedLimitX = -800
	if isWaveDashing and waveDashChainTimer == 0.4525:
		speedLimitX = 800 + (waveDashChainCounter * 100)
		negSpeedLimitX = -800 - (waveDashChainCounter * 100)
		waveDashChainCounter += 1
	if speedLimitX > 1400 or negSpeedLimitX < -1400:
		speedLimitX = 1400
		negSpeedLimitX = -1400
	
	# Allows wallbounces to be higher than a typical wall jump
	if wallBounceSpeedTimer <= 0:
		negSpeedLimitY = -800
	if velocity.x != 0:
		prevX = velocity.x
	
	# Creates collision with certain blocks depending on tagger/not
	if is_it:
		set_collision_mask_value(3, true)
		set_collision_mask_value(2, false)
	else:
		set_collision_mask_value(2, true)
		set_collision_mask_value(3, false)
		
	# Creates cooldown timer on tagging and sets label
	if is_it and tag_cooldown_timer > 0:
		tag_cooldown_timer = max(tag_cooldown_timer - delta, 0)
		if cooldown_label:
			cooldown_label.text = str(snapped(tag_cooldown_timer, 1))
			cooldown_label.visible = true
	else:
		if cooldown_label:
			cooldown_label.visible = false


	# Checks for and allows movement/jumping
	jump()
	movement(delta)
	speedFallOff(delta)
	move_and_slide()
	animate()
