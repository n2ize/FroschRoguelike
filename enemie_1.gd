extends CharacterBody2D


const SPEED = 300.0
var player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$Area2D.body_entered.connect(_on_body_entered)
	print("ich lebe")
	
func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	var direction = (player.global_position - global_position).normalized()
	var separation = Vector2.ZERO
	for body in $Area2D.get_overlapping_bodies():
		if body == self:
			continue
		if body.is_in_group("enemy"):
			var away = global_position - body.global_position
			if away.length() > 0:
				separation += away.normalized() *50
	velocity = direction * SPEED + separation
	move_and_slide()
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		print("hit")
