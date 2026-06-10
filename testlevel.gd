extends Node2D
const Enemy = preload("res://enemy_1.tscn")
const Frog = preload("res://frog_1.tscn")
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	$Timer.timeout.connect(_on_timer_timeout)
	var vp = get_viewport_rect().size
	spawn_player(Vector2(vp.x/2, vp.y/2))

func _on_timer_timeout():
	var vp = get_viewport_rect().size
	spawn_enemy(Vector2(randf_range(0, vp.x), randf_range(0, vp.y)))
	
func spawn_enemy(pos: Vector2):
	var enemy = Enemy.instantiate()
	enemy.position = pos
	add_child(enemy)
	enemy.died.connect(_on_enemy_died)
	
func spawn_player(pos: Vector2):
	var player = Frog.instantiate()
	player.position = pos
	add_child(player)
	
func _on_enemy_died():
	score += randi_range(7, 12)
	$CanvasLayer/Score.text = str(score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
