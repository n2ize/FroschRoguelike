extends Node2D
const Enemy = preload("res://enemie_1.tscn")
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var vp = get_viewport_rect().size
	spawn_enemy(Vector2(randf_range(0, vp.x), randf_range(0, vp.y)))
	
func spawn_enemy(pos: Vector2):
	var enemy = Enemy.instantiate()
	enemy.position = pos
	add_child(enemy)
	enemy.died.connect(_on_enemy_died)
	
func _on_enemy_died():
	score += randi_range(7, 12)
	$CanvasLayer/Score.text = str(score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
