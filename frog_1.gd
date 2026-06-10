extends CharacterBody2D
const SPEED = 800.0
var time = 0.0
var target_base_scale = 1.0
var current_amplitude = deg_to_rad(5)
var last_direction = Vector2.RIGHT
var health = 3
var invincible = false

const Deatheffect = preload("res://gpu_particles_deathparticles.tscn")
const Hiteffect = preload("res://hitindicatorparticles.tscn")
const Bullet = preload("res://Bullet.tscn")

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
		last_direction = direction
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
	
	if Input.is_action_just_pressed("left_click"):
		shoot()
		
func shoot():
	var bullet = Bullet.instantiate()
	bullet.position = global_position
	bullet.direction = last_direction
	get_parent().add_child(bullet)

func take_damage():
	if invincible: 
		return
	health -= 1
	$Label.text = str(health)
	var effect = Hiteffect.instantiate()
	effect.position = position
	get_parent().add_child(effect)
	effect.restart()
	invincible = true 
	sprite.material.set_shader_parameter("modulate_color", Color.WHITE * 2.0)
	await get_tree().create_timer(0.1).timeout
	sprite.material.set_shader_parameter("modulate_color", Color.WHITE)
	invincible = false
	
	if health == 0:
		die()
		
func die():
	var effect = Deatheffect.instantiate()
	effect.position = position
	get_parent().add_child(effect)
	effect.restart()
	queue_free()
	
