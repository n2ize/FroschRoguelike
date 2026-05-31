extends CharacterBody2D
const SPEED = 800.0
var time = 0.0
var target_base_scale = 1.0
var current_amplitude = deg_to_rad(5)
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	time += delta
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
		target_base_scale = 0.8
		current_amplitude = lerp(current_amplitude, deg_to_rad(10), 0.1)
	else:
		velocity = Vector2.ZERO
		target_base_scale = 0.9
		current_amplitude = lerp(current_amplitude, deg_to_rad(2), 0.1)
	
	var current_base_scale = lerp(sprite.scale.y, target_base_scale, 0.1)
	sprite.scale.y = current_base_scale + sin(time * 10) * 0.02
	
	
	sprite.rotation = sin(time * 10) * current_amplitude
	
	move_and_slide()
