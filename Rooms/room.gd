extends Node2D

const Enemy = preload("res://Enemies/enemy_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(2):
		var enemy = Enemy.instantiate()
		enemy.position = Vector2(randf_range(200, 1720), randf_range(200, 880))
		$EnemyContainer.add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_doors(north: bool, south: bool, east: bool, west: bool):
	$Walls/TopWalls/WallTopMiddle.visible = !north
	$Walls/BotWalls/WallBotMiddle.visible = !south
	$Walls/RightWalls/WallRightMiddle.visible = !east
	$Walls/LeftWalls/WallLeftMiddle.visible = !west
	$Walls/TopWalls/WallTopMiddle/CollisionShape2D.disabled = north
	$Walls/BotWalls/WallBotMiddle/CollisionShape2D.disabled = south
	$Walls/RightWalls/WallRightMiddle/CollisionShape2D.disabled = east
	$Walls/LeftWalls/WallLeftMiddle/CollisionShape2D.disabled = west
