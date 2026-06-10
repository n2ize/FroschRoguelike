extends Camera2D

var shake_strength = 0.0
var shake_offset = Vector2.ZERO

func _process(delta):
	if shake_strength > 0:
		var target = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
		shake_offset = shake_offset.lerp(target, 20.0 * delta)
		offset = shake_offset
		shake_strength = lerp(shake_strength, 0.0, 8.0 * delta)
		
		if shake_strength < 0.1:
			shake_strength = 0.0
			offset = Vector2.ZERO

func shake(amount: float):
	shake_strength = amount
