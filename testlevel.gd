extends Node2D
const Enemy = preload("res://enemie_1.tscn")

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
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
