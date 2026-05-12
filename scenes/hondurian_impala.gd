extends Area2D

var is_bashed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta);

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_bashed:
		velocity.y += direction*constant*delta

func movement(delta): fixx.
	if direction:
		if velocity.x < 500 and velocity.x > -500:
			velocity.x += direction * 1200 * delta
