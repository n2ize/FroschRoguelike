extends CharacterBody2D
signal health_changed(current_health)
const SPEED = 800.0
var time = 0.0
var target_base_scale = 1.0
var current_amplitude = deg_to_rad(5)
var last_direction = Vector2.RIGHT
var health = 3.0
var invincible = false

const acc = 5000 #acceleration
const friction = 6000
const Deatheffect = preload("res://Effects/gpu_particles_deathparticles.tscn")
const Hiteffect = preload("res://Effects/hitindicatorparticles.tscn")
const Bullet = preload("res://Weapons/Bullet.tscn")


@onready var sprite = $Sprite2D

func _ready()-> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.RED
	
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
		velocity = velocity.move_toward(
			direction * SPEED,
			acc * delta)
		target_base_scale = 0.8
		current_amplitude = lerp(current_amplitude, deg_to_rad(10), 0.1)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			friction * delta)
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

func take_damage(amount: int):
	if invincible: 
		return
	health -= amount
	health_changed.emit(health) #an die ui geschickt
	if health <= 0:
		die()
		return
	get_viewport().get_camera_2d().shake(100.0)
	var effect = Hiteffect.instantiate()
	effect.position = position
	get_parent().add_child(effect)
	effect.restart()
	invincible = true 
	sprite.material.set_shader_parameter("modulate_color", Color.WHITE * 2.0)
	await get_tree().create_timer(0.3).timeout
	sprite.material.set_shader_parameter("modulate_color", Color.WHITE)
	invincible = false
	
	
		
func die():
	get_viewport().get_camera_2d().shake(500.0)
	var effect = Deatheffect.instantiate()
	effect.position = position
	get_parent().add_child(effect)
	effect.restart()
	UI_Manager.show_death_screen()
	queue_free()
	
