extends Area2D
var direction = Vector2.ZERO
const SPEED = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * SPEED * delta  
	pass
	
func _on_body_entered(body):
	if body.is_in_group("Wall"):
		queue_free()
		#pass
